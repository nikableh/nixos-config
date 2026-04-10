{ pkgs, ... }:
pkgs.writeShellApplication {
  name = "git-oss";

  runtimeInputs = with pkgs; [ git ];

  text = ''
    git config user.name "Nika Krasnova"
    git config user.email "nika@nikableh.moe"
    git config user.signingkey 90AB07612815096E
  '';
}
