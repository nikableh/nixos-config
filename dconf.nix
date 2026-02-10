{ lib, ... }:
{
  programs.dconf = {
    enable = true;
    profiles.user.databases = [
      {
        lockAll = true; # prevents overriding
        settings = {
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

          "org/gnome/desktop/peripherals/touchpad" = {
            disable-while-typing = true;
          };

          "org.gnome.settings-daemon.plugins.housekeeping" = {
            donation-reminder-enabled = false;
          };
        };
      }
    ];
  };
}
