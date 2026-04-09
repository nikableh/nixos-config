{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./dconf.nix
    ./software.nix
    ./scripts.nix
    ./services.nix
    ./printers.nix
  ];

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };

    gc = {
      automatic = true;
      dates = "daily";
      options = "--detele-older-than 10d";
    };
  };

  environment = {
    shellAliases = {
      cfg-rebuild = "sudo nixos-rebuild switch";
      merge = "sublime_merge";
    };

    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };

  xdg.portal.enable = true;
  hardware.graphics.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  system.autoUpgrade = {
    enable = true;
    dates = "weekly";
  };

  networking.hostName = "semk";
  networking.networkmanager.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 3000 ]; # for Nuxt development server
  };

  time.timeZone = "Europe/Belgrade";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  virtualisation.libvirtd.enable = true;

  system.stateVersion = "25.05";
}
