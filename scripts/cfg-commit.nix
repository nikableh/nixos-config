{ pkgs, ... }:
pkgs.writeShellApplication {
  name = "cfg-commit";

  runtimeInputs = with pkgs; [
    git
    nixfmt-tree
  ];

  text = ''
    pushd /etc/nixos

    echo "================="
    echo "Formatting files:"
    echo "================="
    ${pkgs.nixfmt-tree}/bin/treefmt

    ${pkgs.git}/bin/git add -A

    echo "====================="
    echo "Running 'git commit':"
    echo "====================="
    ${pkgs.git}/bin/git commit -m "Backup config"


    echo "==================="
    echo "Running 'git push':"
    echo "==================="
    ${pkgs.git}/bin/git push

    echo
    popd
  '';
}
