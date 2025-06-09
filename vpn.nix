{ ... }:
{
  environment.shellAliases = {
    vpn-up = "sudo systemctl start openvpn-omp";
    vpn-down = "sudo systemctl stop openvpn-omp";
  };

  services.openvpn.servers = {
    omp = {
      config = ''config /home/synalice/Documents/omp/n.krasnov.ovpn '';
      updateResolvConf = true;
      autoStart = false;
    };
  };
}
