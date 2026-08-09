{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    albumwm = {
      url = "github:poli0iq/albumwm";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nixos-hardware,
      home-manager,
      nix-index-database,
      ...
    }@inputs:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;

      mkHost =
        hostModules:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./system
            ./home
            home-manager.nixosModules.home-manager
            nix-index-database.nixosModules.nix-index
          ]
          ++ hostModules;
        };
    in
    {
      formatter.x86_64-linux = pkgs.nixfmt-tree;

      # Covers what the hook misses: rebases, cherry-picks, and machines
      # home-manager has not set core.hooksPath on yet.
      checks.x86_64-linux.treefmt = pkgs.runCommandLocal "check-treefmt" { } ''
        cp -r ${./.} actual
        chmod -R u+w actual
        cp -r actual expected

        ${pkgs.nixfmt-tree}/bin/treefmt \
          --tree-root "$PWD/expected" \
          --walk filesystem \
          --no-cache \
          --on-unmatched debug

        # Not `--fail-on-change`: it compares size and whole-second mtime, so
        # it misses reformats that preserve the byte count.
        if ! diff --recursive --unified actual expected; then
          echo >&2
          echo "the tree is not treefmt-clean; run 'nix fmt' at the repo root" >&2
          exit 1
        fi

        touch "$out"
      '';

      nixosConfigurations = {
        semk = mkHost [
          ./hosts/semk
          nixos-hardware.nixosModules.xiaomi-redmibook-16-pro-2024
        ];

        aleph = mkHost [
          ./hosts/aleph
          nixos-hardware.nixosModules.common-cpu-intel
          nixos-hardware.nixosModules.common-pc-laptop
          nixos-hardware.nixosModules.common-pc-laptop-ssd
        ];
      };
    };
}
