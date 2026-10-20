{ ... }:
{
  home = {
    sessionVariables.NIXOS_OZONE_WL = "1";
    sessionVariables.CODEX_LINUX_DISABLE_USAGE_REPORTING = "1";
    sessionVariables.CODEX_COMPUTER_USE_PERSIST_REMOTE_DESKTOP = "1";
    shellAliases = {
      clob = "claude";
      cloba = "claude agents";
    };
  };
}
