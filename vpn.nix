{ ... }:
{
  # sudo systemctl start/stop openvpn-omp
  services.openvpn.servers = {
    omp = {
      config = "config /root/n.krasnov.ovpn";
      updateResolvConf = true;
      autoStart = false;
    };
  };
}
