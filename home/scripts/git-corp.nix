{ pkgs, ... }:
pkgs.writeShellApplication {
  name = "git-corp";

  runtimeInputs = with pkgs; [ git ];

  text = ''
    git config user.name "Nikita Krasnov"
    git config user.email "n.krasnov@omp.ru"
    git config user.signingkey F805F74375AC361A
  '';
}
