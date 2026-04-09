{ pkgs, ... }:
{
  services.printing = {
    enable = true;
    drivers = [
      pkgs.hplipWithPlugin
      pkgs.gutenprint
      pkgs.canon-cups-ufr2
      pkgs.cups-filters
      pkgs.cups-kyocera
      pkgs.epson-escpr
    ];
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
