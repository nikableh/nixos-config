{ pkgs, ... }:
{
  services = {
    logind.settings.Login.HandleLidSwitch = "lock";
    acpid.enable = true;
    flatpak.enable = true;
    pulseaudio.enable = false;

    xserver = {
      enable = true;
      excludePackages = [ pkgs.xterm ];
      xkb = {
        layout = "us,ru";
        variant = "";
      };
    };

    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;

    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };

    libinput = {
      enable = true;
      touchpad.disableWhileTyping = true;
    };

    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
        AllowUsers = [
          "synalice"
          "nikableh"
        ];
      };
    };
  };

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

  environment.gnome.excludePackages = with pkgs; [
    gnome-tour # I don't need a tutorial
    epiphany # I use Google Chrome
  ];

  security.rtkit.enable = true;

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
}
