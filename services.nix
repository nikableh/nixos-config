{ pkgs, ... }:
{
  services.acpid.enable = true;

  systemd.services.enableXiaomiButton = {
    script = ''
      setkeycodes e072 193
    '';
    wantedBy = [ "multi-user.target" ];
    path = [ "/run/current-system/sw" ];
    serviceConfig = {
      Type = "oneshot";
    };
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

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = [ "synalice" ];
    };
  };
}
