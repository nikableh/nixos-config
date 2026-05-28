{ pkgs, ... }:
pkgs.writeShellApplication {
  name = "cfg-open";

  text = ''
    code /etc/nixos
  '';
}
