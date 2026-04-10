{ pkgs, ... }:
{
  home.packages = [
    (pkgs.callPackage ./scripts/cfg-commit.nix { })
    (pkgs.callPackage ./scripts/cfg-open.nix { })
    (pkgs.callPackage ./scripts/cfg-rebuild.nix { })
    (pkgs.callPackage ./scripts/git-corp.nix { })
    (pkgs.callPackage ./scripts/git-oss.nix { })
  ];
}
