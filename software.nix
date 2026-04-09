{ pkgs, ... }:
{
  imports = [
    ./software/obs-studio.nix
    ./software/docker.nix
    ./software/keyd.nix
  ];

  programs.adb.enable = true;

  programs.nano.enable = false;

  programs.neovim.enable = true;
  programs.direnv.enable = true;
  programs.steam.enable = true;

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
      diff.tool = "meld";
    };
  };

  environment.systemPackages = with pkgs; [
    unstable.sublime-merge-dev
    unstable.android-studio
    unstable.windsurf
    unstable.shotcut
    unstable.claude-code
    unstable.slack
    unstable.discord
    unstable.google-chrome
    unstable.ayugram-desktop
    unstable.vscode

    file
    pciutils
    fastfetch
    wl-clipboard
    gnome-tweaks
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
    openvpn
    nixfmt-rfc-style
    nil
    sensible-utils
    libreoffice
    gucharmap
    obsidian
    inkscape
    godotPackages_4_5.godot
    firefox
    blender
    pdfarranger
    gnome-boxes
    glab
    prismlauncher
    liberation_ttf
    vista-fonts
    meld
    icon-library
    typst
    typstyle
    tinymist
    ffmpeg
    zulu25
  ];
}
