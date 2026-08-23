{ ... }:
{
  home = {
    sessionVariables.NIXOS_OZONE_WL = "1";
    sessionVariables.CODEX_LINUX_DISABLE_USAGE_REPORTING = "1";
    shellAliases = {
      clob = "claude";
      cloba = "claude agents";
    };
  };
}
