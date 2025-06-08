{ config, pkgs, ... }:

{
  imports = [
    <nixos-hardware/xiaomi/redmibook/16-pro-2024>
    ./hardware-configuration.nix
    ./dconf.nix
    ./software.nix
    ./scripts.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

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

  services.xserver.enable = true;

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  services.xserver.excludePackages = [ pkgs.xterm ];
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    epiphany
    gnome-connections
    yelp
    gnome-maps
    gnome-music
    decibels
    totem
    geary
  ];

  services.xserver.xkb = {
    layout = "us,ru";
    variant = "";
    options = "caps:escape";
  };

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.libinput.enable = true;

  users.users.synalice = {
    isNormalUser = true;
    description = "synalice";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  nixpkgs.config.allowUnfree = true;

  environment.shellAliases = {
    rebuild = "sudo nixos-rebuild switch";
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = [ "synalice" ];
    };
  };

  system.stateVersion = "25.05";
}
