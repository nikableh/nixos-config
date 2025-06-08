{ pkgs, ... }:
{
  imports = [
    ./obs-studio.nix
  ];

  environment.systemPackages = with pkgs; [
    neovim
    file
    pciutils
    git
    fastfetch
    wl-clipboard
    google-chrome
    telegram-desktop
    gnome-tweaks
    sublime-merge
    mattermost-desktop
    nixfmt-tree
    copyq
    dconf-editor
    dconf2nix
    qbittorrent
    vlc
    xorg.xev
    ripgrep
    evtest
    bat
    tree
  ];
}
