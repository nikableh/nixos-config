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
        };
      }
    ];
  };
}
