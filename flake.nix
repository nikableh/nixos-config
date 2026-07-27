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
