{ pkgs, config, ... }:

{
  imports = [
    <nixos-hardware/xiaomi/redmibook/16-pro-2024>
    ./hardware-configuration.nix
    ./dconf.nix
    ./software.nix
    ./scripts.nix
    ./services.nix
    ./vpn.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  environment.shellAliases = {
    cfg-rebuild = "sudo nixos-rebuild switch";
    merge = "sublime_merge";
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

  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--detele-older-than 10d";
  };

  networking.hostName = "semk";
  networking.networkmanager.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 3000 ]; # for Nuxt development server
  };

  time.timeZone = "Europe/Moscow";
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
    packageOverrides = pkgs: {
      # nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
      # nix-channel --update
      unstable = import <nixos-unstable> {
        config = config.nixpkgs.config;
      };
    };
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  virtualisation.libvirtd.enable = true;

  system.stateVersion = "25.05";
}
