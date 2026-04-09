{ pkgs, ... }:
{
  home.packages = [
    (pkgs.callPackage ../system/scripts/cfg-commit.nix { })
    (pkgs.callPackage ../system/scripts/cfg-open.nix { })
    (pkgs.callPackage ../system/scripts/cfg-rebuild.nix { })
    (pkgs.callPackage ../system/scripts/git-corp.nix { })
    (pkgs.callPackage ../system/scripts/git-oss.nix { })
  ];
}
