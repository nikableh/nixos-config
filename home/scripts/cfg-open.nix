{ pkgs, ... }:
pkgs.writeShellApplication {
  name = "cfg-open";

  runtimeInputs = with pkgs; [
    vscode
  ];

  text = ''
    code /etc/nixos
  '';
}
