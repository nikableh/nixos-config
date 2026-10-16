{ lib, pkgs, ... }:
{
  virtualisation.virtualbox.host = {
    enable = true;
    # Qt's GTK file chooser aborts without org.gtk.Settings.FileChooser.
    package = lib.makeOverridable (
      args:
      let
        virtualbox = pkgs.virtualbox.override args;
      in
      pkgs.symlinkJoin {
        name = "virtualbox-${virtualbox.version}";
        inherit (virtualbox) version meta;
        paths = [ virtualbox ];
        nativeBuildInputs = [ pkgs.makeWrapper ];
        postBuild = ''
          wrapProgram "$out/bin/VirtualBox" \
            --prefix XDG_DATA_DIRS : "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
        '';
        passthru =
          virtualbox.passthru
          // lib.optionalAttrs (virtualbox ? modsrc) {
            inherit (virtualbox) modsrc;
          };
      }
    ) { };
  };
  users.users.nikableh.extraGroups = [ "vboxusers" ];
}
