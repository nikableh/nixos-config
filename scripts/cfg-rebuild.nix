{ pkgs, ... }:
pkgs.writeShellApplication {
  name = "cfg-rebuild";

  text = ''
    sudo nixos-rebuild switch
  '';
}
