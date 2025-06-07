{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    (callPackage ./scripts/cfg-commit.nix { })
  ];
}
