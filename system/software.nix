{ ... }:
{
  imports = [
    ./software/obs-studio.nix
    ./software/docker.nix
    ./software/keyd.nix
  ];

  programs.adb.enable = true;
  programs.nano.enable = false;
  programs.steam.enable = true;
}
