{ ... }:
{
  virtualisation.docker.enable = true;
  users.users.nikableh.extraGroups = [ "docker" ];
}
