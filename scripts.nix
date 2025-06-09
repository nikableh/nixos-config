{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    (callPackage ./scripts/cfg-commit.nix { })
    (callPackage ./scripts/git-corp.nix { })
    (callPackage ./scripts/git-oss.nix { })
  ];
}
