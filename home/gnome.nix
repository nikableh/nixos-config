{
  pkgs,
  lib,
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

    "org/gnome/shell/keybindings" = {
      toggle-message-tray = lib.hm.gvariant.mkEmptyArray lib.hm.gvariant.type.string;
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>v";
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
