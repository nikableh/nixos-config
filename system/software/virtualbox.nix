{ ... }:
{
  virtualisation.virtualbox.host.enable = true;
  users.users.nikableh.extraGroups = [ "vboxusers" ];
}
