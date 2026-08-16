{
  pkgs,
  lib,
  inputs,
  ...
}:
{
  programs.gnome-shell = {
    enable = true;

    extensions = with pkgs.gnomeExtensions; [
      { package = vitals; }
      { package = blur-my-shell; }
      { package = middle-click-to-close-in-overview; }
      { package = caffeine; }
      { package = inputs.albumwm.packages.${pkgs.stdenv.hostPlatform.system}.default; }
    ];
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      show-battery-percentage = true;
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Alt>v";
      command = "copyq toggle";
      name = "Toggle CopyQ";
    };

    "org/gnome/desktop/input-sources" = {
      xkb-options = [ "caps:escape" ];
      sources = [
        (lib.hm.gvariant.mkTuple [
          "xkb"
          "us+colemak"
        ])
        (lib.hm.gvariant.mkTuple [
          "xkb"
          "rulemak-caps-escape"
        ])
      ];

      # Required for non-standard layouts to work
      show-all-sources = true;
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      disable-while-typing = true;
    };

    "org/gnome/desktop/screensaver" = {
      restart-enabled = true;
    };

    "org/gnome/settings-daemon/plugins/housekeeping" = {
      donation-reminder-enabled = false;
    };

    "org/gnome/shell/extensions/vitals" = {
      hot-sensors = [
        "__temperature_avg__"
        "_memory_usage_"
        "_processor_usage_"
      ];
      icon-style = 1;
    };
  };
}
