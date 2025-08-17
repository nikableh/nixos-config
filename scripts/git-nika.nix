{ pkgs, ... }:
pkgs.writeShellApplication {
  name = "git-nika";

  runtimeInputs = with pkgs; [ git ];

  text = ''
    git config user.name "Nika"
    git config user.email "nika@nikableh.moe"
    git config user.signingkey 90AB07612815096E
  '';
}
