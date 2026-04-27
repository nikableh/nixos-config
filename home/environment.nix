{ ... }:
{
  home = {
    sessionVariables.NIXOS_OZONE_WL = "1";
    shellAliases = {
      merge = "sublime_merge";
      claude-danger = "claude --dangerously-skip-permissions";
    };
  };
}
