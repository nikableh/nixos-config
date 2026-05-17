{ pkgs, ... }:
pkgs.writeShellApplication {
  name = "cfg-open";

  runtimeInputs = with pkgs; [
    unstable.vscode
  ];

  text = ''
    code /etc/nixos
  '';
}
