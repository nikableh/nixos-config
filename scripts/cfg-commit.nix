{ pkgs, ... }:
pkgs.writeShellApplication {
  name = "cfg-commit";

  runtimeInputs = with pkgs; [
    git
    nixfmt-tree
  ];

  text = ''
    pushd /etc/nixos

    printf "\n=================\n"
    echo     "Formatting files:"
    printf "\n=================\n"
    ${pkgs.nixfmt-tree}/bin/treefmt

    ${pkgs.git}/bin/git add -A

    printf "\n=====================\n"
    echo     "Running 'git commit':"
    printf "\n=====================\n"
    ${pkgs.git}/bin/git commit -m "Backup config"


    printf "\n===================\n"
    echo     "Running 'git push':"
    printf "\n===================\n"
    ${pkgs.git}/bin/git push

    printf
    popd
  '';
}
