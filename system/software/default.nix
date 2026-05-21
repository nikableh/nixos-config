{ ... }:
{
  imports = [
    ./obs-studio.nix
    ./docker.nix
  ];

  programs = {
    adb.enable = true;
    nano.enable = false;
    steam.enable = true;
  };
}
