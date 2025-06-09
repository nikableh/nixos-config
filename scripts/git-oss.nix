{ pkgs, ... }:
pkgs.writeShellApplication {
  name = "git-oss";

  runtimeInputs = with pkgs; [ git ];

  text = ''
    git config user.name "Nikita Krasnov"
    git config user.email "nikita.nikita.krasnov@gmail.com"
    git config user.signingkey 97194DB3A4C77F31
  '';
}
