{ ... }:
{
  imports = [
    ./obs-studio.nix
    ./docker.nix
  ];

  programs = {
    nano.enable = false;
    steam.enable = true;
  };
}
