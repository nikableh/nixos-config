{ ... }:
{
  programs.bash.enable = true;
  programs.neovim.enable = true;
  programs.direnv.enable = true;

  programs.git = {
    enable = true;
    lfs.enable = true;
    extraConfig = {
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
  };

  services.copyq.enable = true;
}
