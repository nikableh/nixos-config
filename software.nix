{ pkgs, ... }:
{
  imports = [
    ./software/obs-studio.nix
    ./software/docker.nix
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
    ripgrep
    evtest
    bat
    tree
    bustle
    wev
    gimp
  ];
}
