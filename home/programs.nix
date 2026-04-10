{ pkgs, ... }:
{
  programs.bash.enable = true;
  programs.neovim.enable = true;
  programs.direnv.enable = true;

  programs.git = {
    enable = true;
    lfs.enable = true;
    settings = {
      init.defaultBranch = "main";
      gpg.format = "openpgp";
      commit.gpgsign = true;
      tag.gpgSign = true;
      core.editor = "nvim";
      diff.tool = "meld";
    };
  };

  programs.gpg.enable = true;

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentry.package = pkgs.pinentry-gnome3;
    defaultCacheTtl = 86400;
    maxCacheTtl = 86400;
    defaultCacheTtlSsh = 86400;
    maxCacheTtlSsh = 86400;
  };

  services.copyq.enable = true;
}
