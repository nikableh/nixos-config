{ pkgs, ... }:
pkgs.writeShellApplication {
  name = "cfg-commit";

  runtimeInputs = with pkgs; [
    git
    nixfmt-tree
  ];

  text = ''
    pushd /etc/nixos

    git add -A

    printf "\n================\n"
    printf "Formatting files\n"
    printf "================\n\n"
    treefmt

    git add -A

    printf "\n====================\n"
    printf "Running 'git commit'\n"
    printf "====================\n\n"
    git commit -m "Backup config"


    printf "\n==================\n"
    printf "Running 'git push'\n"
    printf "==================\n\n"
    git push

    echo

    popd
  '';
}
