{ ... }:
{
  systemd.services.enableXiaomiButton = {
    script = ''
      setkeycodes e072 193
    '';
    wantedBy = [ "multi-user.target" ];
    path = [ "/run/current-system/sw" ];
    serviceConfig = {
      Type = "oneshot";
    };
  };
}
