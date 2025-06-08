{ pkgs, ... }:
pkgs.writeShellApplication {
  name = "cfg-commit";

  runtimeInputs = with pkgs; [
    git
    nixfmt-tree
  ];

  text = ''
    pushd /etc/nixos

    printf "\n================\n"
    printf "Formatting files\n"
    printf "================\n\n"
    ${pkgs.nixfmt-tree}/bin/treefmt

    ${pkgs.git}/bin/git add -A

    printf "\n====================\n"
    printf "Running 'git commit'\n"
    printf "====================\n\n"
    ${pkgs.git}/bin/git commit -m "Backup config"


    printf "\n==================\n"
    printf "Running 'git push'\n"
    printf "==================\n\n"
    ${pkgs.git}/bin/git push

    printf
    popd
  '';
}
