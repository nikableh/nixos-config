{ pkgs, ... }:
{
  services.printing = {
    enable = true;
    drivers = [
      pkgs.hplipWithPlugin
      pkgs.gutenprint
      pkgs.canon-cups-ufr2
      pkgs.cups-filters
      pkgs.cups-kyocera-3500-4500
      pkgs.cups-kyocera
      pkgs.epson-escpr
      # (pkgs.callPackage ./Kyocera_CS_2551ci/Kyocera_CS_2551ci.nix {})
    ];
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
