{ lib, pkgs, ... }:
{
  nixpkgs.overlays = [
    (_: prev: {
      linuxPackages_latest = prev.linuxPackages_latest.extend (
        kernelFinal: kernelPackages: {
          virtualbox = kernelPackages.virtualbox.overrideAttrs (old: {
            # Use NixOS's module signing rule during installation.
            makeFlags =
              (old.makeFlags or [ ])
              ++ kernelFinal.kernelModuleMakeFlags
              ++ [
                "VBOX_ALLOW_MODULE_SIGNING=1"
              ];
          });
        }
      );
    })
  ];

  virtualisation.virtualbox.host = {
    enable = true;
    # Qt's GTK file chooser aborts without org.gtk.Settings.FileChooser.
    package = lib.makeOverridable (
      args:
      let
        virtualbox = (pkgs.virtualbox.override args).overrideAttrs (old: {
          postPatch = (old.postPatch or "") + ''
            substituteInPlace src/libs/dxvk-*/src/vulkan/vulkan_loader.cpp \
              --replace-fail '"libvulkan.so"' '"${lib.getLib pkgs.vulkan-loader}/lib/libvulkan.so.1"' \
              --replace-fail '"libvulkan.so.1"' '"${lib.getLib pkgs.vulkan-loader}/lib/libvulkan.so.1"'
          '';
        });
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
