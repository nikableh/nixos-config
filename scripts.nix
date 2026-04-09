{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    (callPackage ./scripts/cfg-commit.nix { })
    (callPackage ./scripts/cfg-open.nix { })
    (callPackage ./scripts/cfg-rebuild.nix { })
    (callPackage ./scripts/git-corp.nix { })
    (callPackage ./scripts/git-oss.nix { })
  ];
}
