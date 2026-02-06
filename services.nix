{ pkgs, ... }:
{
  services.logind.settings.Login.HandleLidSwitch = "lock";

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

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

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

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.libinput = {
    enable = true;
    touchpad.disableWhileTyping = true;
  };

  users.users.synalice = {
    isNormalUser = true;
    description = "synalice";
    extraGroups = [
      "networkmanager"
      "wheel"
      "kvm"
      "render"
      "adbusers"
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

  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    user = "synalice";
    dataDir = "/home/synalice";
  };

  services.flatpak.enable = true;
}
