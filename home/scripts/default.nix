{ pkgs, ... }:
{
  home.packages = [
    (pkgs.callPackage ./cfg-commit.nix { })
    (pkgs.callPackage ./cfg-open.nix { })
    (pkgs.callPackage ./cfg-rebuild.nix { })
    (pkgs.callPackage ./git-oss.nix { })
  ];
}
