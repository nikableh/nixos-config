{ pkgs, ... }:
{
  imports = [
    ./software/obs-studio.nix
    ./software/docker.nix
    ./software/keyd.nix
  ];

  programs.nano.enable = false;

  programs.neovim.enable = true;
  programs.direnv.enable = true;
  programs.steam.enable = true;
  programs.thunderbird = {
    enable = true;
    package = pkgs.thunderbird-esr;
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.git = {
    enable = true;
    lfs.enable = true;
    config = {
      init.defaultBranch = "main";
      gpg.format = "openpgp";
      commit.gpgsign = true;
      tag.gpgSign = true;
      core.editor = "nvim";
    };
  };

  environment.systemPackages = with pkgs; [
    file
    pciutils
    fastfetch
    wl-clipboard
    google-chrome
    telegram-desktop
    gnome-tweaks
    unstable.sublime-merge-dev
    mattermost-desktop
    nixfmt-tree
    copyq
    dconf-editor
    dconf2nix
    qbittorrent
    vlc
    ripgrep
    evtest
    bat
    tree
    bustle
    wev
    gimp
    vscode
    openvpn
    nixfmt-rfc-style
    nil
    sensible-utils
    libreoffice
    shotcut
    gucharmap
    obsidian
  ];
}
