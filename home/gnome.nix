{
  pkgs,
  lib,
  ...
}:
let
  copyqExtensionId = "copyq-clipboard@hluk.github.com";
  # Backport GNOME 50 support until CopyQ ships a release containing this fix:
  # https://github.com/hluk/CopyQ/pull/3699
  copyqExtension = pkgs.runCommand "copyq-gnome50-extension" { } ''
    cp -rL ${pkgs.copyq}/share/gnome-shell/extensions/${copyqExtensionId} "$out"
    chmod u+w "$out" "$out/metadata.json"
    ${lib.getExe pkgs.jq} '."shell-version" |= (. + ["50"] | unique)' \
      "$out/metadata.json" > "$out/metadata.json.new"
    mv "$out/metadata.json.new" "$out/metadata.json"
  '';
in
{
  programs.gnome-shell = {
    enable = true;

    extensions = with pkgs.gnomeExtensions; [
      { package = vitals; }
      { package = blur-my-shell; }
      { package = middle-click-to-close-in-overview; }
      { package = caffeine; }
      {
        id = copyqExtensionId;
        package = pkgs.copyq;
      }
    ];
  };

  home.file.".local/share/gnome-shell/extensions/${copyqExtensionId}".source = copyqExtension;

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
