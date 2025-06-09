{ pkgs, ... }:
pkgs.writeShellApplication {
  name = "git-corp";

  runtimeInputs = with pkgs; [ git ];

  text = ''
    git config user.name "Nikita Krasnov"
    git config user.email "n.krasnov@omp.ru"
    git config user.signingkey A399E65C057AC6B3
  '';
}
