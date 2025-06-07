{ pkgs, ...}: {
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
    nixfmt-rfc-style
  ];
}
