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

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.nikableh = {
    imports = [
      ./packages.nix
      ./programs.nix
      ./environment.nix
      ./dconf.nix
      ./scripts.nix
      ./ssh.nix
    ];

    systemd.user.startServices = "sd-switch";

    home.stateVersion = "25.11";
  };
}
