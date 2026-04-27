{ ... }:
{
  home = {
    sessionVariables.NIXOS_OZONE_WL = "1";
    shellAliases = {
      merge = "sublime_merge";
      clob = "claude --dangerously-skip-permissions";
    };
  };
}
