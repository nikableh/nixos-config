{ pkgs, ... }:
pkgs.writeShellApplication {
  name = "cfg-update";

  text = ''
    (
      cd /etc/nixos
      sudo nix flake update
    )
  '';
}
