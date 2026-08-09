{ inputs, ... }:
{
  users.users = {
    nikableh = {
      isNormalUser = true;
      extraGroups = [
        "networkmanager"
        "wheel"
        "kvm"
        "render"
        "adbusers"
      ];
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };

    users = {
      nikableh = {
        imports = [
          ./packages.nix
          ./programs.nix
          ./environment.nix
          ./gnome.nix
          ./ssh.nix

          ./git-hooks
          ./scripts
        ];

        systemd.user.startServices = "sd-switch";

        home.stateVersion = "25.11";
      };
    };
  };
}
