{ pkgs, ... }:
pkgs.writeShellApplication {
  name = "cfg-cd";

  text = ''
    cd /etc/nixos
  '';
}
