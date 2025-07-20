{ pkgs, ... }:
pkgs.writeShellApplication {
  name = "git-oss";

  runtimeInputs = with pkgs; [ git ];

  text = ''
    git config user.name "Nikita Krasnov"
    git config user.email "nikita.nikita.krasnov@gmail.com"
    git config user.signingkey E00E7304C17E7786
  '';
}
