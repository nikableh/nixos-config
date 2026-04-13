{ ... }:
{
  imports = [
    ./software/obs-studio.nix
    ./software/docker.nix
    ./software/keyd.nix
  ];

  programs = {
    adb.enable = true;
    nano.enable = false;
    steam.enable = true;
  };
}
