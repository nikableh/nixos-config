{ pkgs, lib, ... }:
let
  rulemak = "rulemak-caps-escape";
in
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
        layout = "us,${rulemak}";
        variant = "colemak,";
        options = "terminate:ctrl_alt_bksp,caps:escape";

        # System-wide so the GDM greeter gets it too. The greeter runs as the
        # `gdm` user and can't read my home directory.
        extraLayouts.${rulemak} = {
          description = "Russian (Rulemak, Caps as Esc)";
          languages = [ "rus" ];
          symbolsFile = ../xkb/symbols/rulemak-caps-escape;
        };
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
        AllowUsers = [ "nikableh" ];
      };
    };
  };

  environment = {
    gnome.excludePackages = with pkgs; [
      gnome-tour # I don't need a tutorial
      epiphany # I use Google Chrome
      gnome-console # I use Ptyxis
    ];

    defaultPackages = with pkgs; [
      ptyxis # Better terminal for gnome
      resources # Better system monitor
    ];
  };

  # GDM's greeter is a separate gnome-shell running as the `gdm` user with its
  # own dconf, so it doesn't see the input sources from home/gnome.nix. Without
  # this, the login screen after a reboot is plain QWERTY.
  programs.dconf.profiles.gdm.databases = [
    {
      settings."org/gnome/desktop/input-sources" = {
        sources = [
          (lib.gvariant.mkTuple [
            "xkb"
            "us+colemak"
          ])
          (lib.gvariant.mkTuple [
            "xkb"
            rulemak
          ])
        ];
        xkb-options = [ "caps:escape" ];
        show-all-sources = true;
      };
    }
  ];

  # extraLayouts hardcodes <shortDescription> to the layout name, and that is
  # what GNOME puts in the top bar. Rulemak is Russian, so it should say `ru`.
  nixpkgs.overlays = [
    (final: prev: {
      xkeyboard-config_custom =
        args:
        (prev.xkeyboard-config_custom args).overrideAttrs (old: {
          postPatch = old.postPatch + ''
            sed -i 's|<shortDescription>${rulemak}</shortDescription>|<shortDescription>ru</shortDescription>|' rules/base.xml
          '';
        });
    })
  ];

  security.rtkit.enable = true;
}
