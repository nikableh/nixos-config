{ ... }:
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

    synalice = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    users = {
      synalice = {
        imports = [ ./synalice.nix ];
      };

      nikableh = {
        imports = [
          ./packages.nix
          ./programs.nix
          ./environment.nix
          ./gnome.nix
          ./ssh.nix

          ./scripts
        ];

        systemd.user.startServices = "sd-switch";

        home.stateVersion = "25.11";
      };
    };
  };
}
