{ ... }:
{
  imports = [
    ./obs-studio.nix
    ./docker.nix
  ];

  nixpkgs.overlays = [
    (final: prev: {
      # Keep CopyQ's clipboard helper on Wayland for every launch method.
      # Remove once unwrapped CopyQ keeps its server and helper on Wayland in GNOME.
      copyq = final.symlinkJoin {
        name = "${prev.copyq.name}-wayland";
        paths = [ prev.copyq ];
        nativeBuildInputs = [ final.makeWrapper ];
        postBuild = ''
          wrapProgram "$out/bin/copyq" --set QT_QPA_PLATFORM wayland
        '';
        inherit (prev.copyq) meta;
      };
    })
  ];

  programs = {
    nano.enable = false;
    steam.enable = true;
    fish.enable = true;
  };
}
