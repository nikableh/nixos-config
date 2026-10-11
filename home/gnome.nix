{
  inputs,
  pkgs,
  lib,
  ...
}:
let
  codexExtensionId = "codex-window-control@openai.com";
  # Keep the bridge in sync with the pinned Codex computer-use backend.
  codexExtensionSource = "${inputs.codex-desktop-linux}/computer-use-linux/gnome-shell-extension";
  codexExtension = pkgs.runCommand "codex-window-control-extension" { } ''
    mkdir -p "$out/share/gnome-shell/extensions"
    cp -r ${codexExtensionSource} "$out/share/gnome-shell/extensions/${codexExtensionId}"
  '';

  copyqExtensionId = "copyq-clipboard@hluk.github.com";
  # Backport GNOME 50 support until CopyQ ships a release containing this fix:
  # https://github.com/hluk/CopyQ/pull/3699
  copyqExtension =
    pkgs.runCommand "copyq-gnome50-extension"
      {
        nativeBuildInputs = [ pkgs.patch ];
      }
      ''
        cp -rL ${pkgs.copyq}/share/gnome-shell/extensions/${copyqExtensionId} "$out"
        chmod u+w "$out" "$out/metadata.json" "$out/extension.js"
        # Keep live clients registered after a transient notification timeout.
        # https://github.com/hluk/CopyQ/commit/73b9fe63a43a73d14ba4750bcb042d42b66a1583
        if ! patch --dry-run --reverse -d "$out" -p1 \
            < ${./patches/copyq-gnome-client-timeout.patch} >/dev/null 2>&1; then
          patch -d "$out" -p1 < ${./patches/copyq-gnome-client-timeout.patch}
        fi
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
        id = codexExtensionId;
        package = codexExtension;
      }
      {
        id = copyqExtensionId;
        package = pkgs.copyq;
      }
    ];
  };

  home.file.".local/share/gnome-shell/extensions/${copyqExtensionId}".source = copyqExtension;

  # Replace the manually installed bridge so it cannot shadow future updates.
  home.file.".local/share/gnome-shell/extensions/${codexExtensionId}" = {
    source = codexExtensionSource;
    recursive = true;
    force = true;
  };

  dconf.settings = {
    "org/gnome/shell" = {
      always-show-log-out = true;
    };

    "org/gnome/desktop/interface" = {
      toolkit-accessibility = true;
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
