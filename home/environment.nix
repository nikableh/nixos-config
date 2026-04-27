{ ... }:
{
  home = {
    sessionVariables.NIXOS_OZONE_WL = "1";
    shellAliases = {
      merge = "sublime_merge";
      claude-bypass = "claude --dangerously-skip-permissions";
    };
  };
}
