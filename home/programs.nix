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
    pinentryPackage = pkgs.pinentry-gnome3;
  };

  services.copyq.enable = true;
}
