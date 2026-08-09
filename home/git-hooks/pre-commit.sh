# shellcheck shell=bash
#
# Reject a commit whose staged content is not treefmt-clean.
#
# Checks a scratch copy of the index, not the working tree, so it sees exactly
# what is about to be committed and never touches your files.
#
# Fails closed: a broken hook rejects the commit.

umask 077

trap 'printf "\ncommit rejected: the pre-commit hook itself failed at line %s\n\nbypass: git commit --no-verify\n\n" "$LINENO" >&2' ERR

repo_root=$(git rev-parse --show-toplevel)

work=$(mktemp -d)
trap 'rm -rf "$work" || true' EXIT
scratch=$work/tree
mkdir "$scratch"

# Lowercase `d` excludes deletions but keeps typechanges, which ACMR misses.
# Via a file, not `< <(git diff ...)`: process substitution hides the exit
# status, so a failing git diff would look like an empty index.
git diff --cached --name-only --diff-filter=d -z >"$work/staged"
staged=()
mapfile -d '' staged <"$work/staged"
if [ ${#staged[@]} -eq 0 ]; then
  exit 0
fi

# Skip paths behind a clean/smudge filter (git-crypt, git-lfs): materialising
# them decrypts secrets into the scratch dir, and fails without the key.
printf '%s\0' "${staged[@]}" | git check-attr --stdin -z filter >"$work/attrs"
attrs=()
mapfile -d '' attrs <"$work/attrs"
declare -A filtered=()
for ((i = 0; i + 2 < ${#attrs[@]}; i += 3)); do
  case ${attrs[i + 2]} in
    unspecified | unset) ;;
    *) filtered[${attrs[i]}]=1 ;;
  esac
done

checkable=()
for file in "${staged[@]}"; do
  [ -n "${filtered[$file]:-}" ] || checkable+=("$file")
done
if [ ${#checkable[@]} -eq 0 ]; then
  exit 0
fi

# xargs rather than a direct expansion, to stay under ARG_MAX.
printf '%s\0' "${checkable[@]}" >"$work/checkable"
if ! checkout_log=$(xargs -0 -r git checkout-index --prefix="$scratch/" -- <"$work/checkable" 2>&1); then
  printf '\ncommit rejected: could not read the staged content\n\n%s\n\nbypass: git commit --no-verify\n\n' "$checkout_log" >&2
  exit 1
fi

# treefmt does not follow symlinks. Removing them keeps it that way.
find "$scratch" -type l -delete

# Hashes, not `treefmt --fail-on-change`: that compares size and whole-second
# mtime, so it misses reformats that preserve the byte count.
declare -A before=()
for file in "${checkable[@]}"; do
  if [ -f "$scratch/$file" ]; then
    before[$file]=$(sha256sum <"$scratch/$file")
  fi
done

if ! treefmt_log=$(treefmt --tree-root "$scratch" --walk filesystem --no-cache -u debug 2>&1); then
  printf '\ncommit rejected: treefmt failed\n\n%s\n\nbypass: git commit --no-verify\n\n' "$treefmt_log" >&2
  exit 1
fi

unformatted=()
for file in "${checkable[@]}"; do
  [ -n "${before[$file]+set}" ] || continue
  after=$(sha256sum <"$scratch/$file")
  [ "$after" = "${before[$file]}" ] || unformatted+=("$file")
done

if [ ${#unformatted[@]} -eq 0 ]; then
  exit 0
fi

# `git add -u` would sweep in unrelated unstaged changes, so name the files.
partial=()
for file in "${unformatted[@]}"; do
  if ! git diff --quiet -- "$file"; then
    partial+=("$file")
  fi
done

{
  printf 'commit rejected: staged content is not treefmt-clean\n\n'
  printf '  %s\n' "${unformatted[@]}"

  printf '\nformat and re-stage:\n\n  cd %q\n  treefmt --' "$repo_root"
  printf ' %q' "${unformatted[@]}"
  printf '\n  git add --'
  printf ' %q' "${unformatted[@]}"
  printf '\n'

  if [ ${#partial[@]} -gt 0 ]; then
    printf '\nwarning: git add will also stage your unstaged changes in:\n\n'
    printf '  %s\n' "${partial[@]}"
  fi

  printf '\nbypass: git commit --no-verify\n\n'
} >&2

exit 1
