{ pkgs, ... }:
{
  virtualisation.docker.enable = true;
  users.users.synalice.extraGroups = [ "docker" ];
}
