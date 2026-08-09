{ pkgs, ... }:
let
  preCommit = pkgs.writeShellApplication {
    name = "pre-commit";

    runtimeInputs = with pkgs; [
      coreutils
      findutils
      git
      gnused
      nixfmt-tree
    ];

    text = builtins.readFile ./pre-commit.sh;
  };

  hooks = pkgs.linkFarm "nixos-config-git-hooks" [
    {
      name = "pre-commit";
      path = "${preCommit}/bin/pre-commit";
    }
    # A merge that resolves cleanly never runs `pre-commit`.
    {
      name = "pre-merge-commit";
      path = "${preCommit}/bin/pre-commit";
    }
  ];
in
{
  # Only this repo gets the hooks; other checkouts keep git's `.git/hooks`.
  programs.git.includes = [
    {
      condition = "gitdir:/etc/nixos/";
      contents.core.hooksPath = "${hooks}";
    }
  ];
}
