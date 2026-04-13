{ ... }:
{
  users.users.nikableh = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "kvm"
      "render"
      "adbusers"
    ];
  };

  users.users.synalice = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.synalice = {
    imports = [ ./synalice.nix ];
  };

  home-manager.users.nikableh = {
    imports = [
      ./packages.nix
      ./programs.nix
      ./environment.nix
      ./gnome.nix
      ./scripts.nix
      ./ssh.nix
    ];

    systemd.user.startServices = "sd-switch";

    home.stateVersion = "25.11";
  };
}
