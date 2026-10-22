{ pkgs, config, ... }:
{
  boot.extraModulePackages = [
    (config.boot.kernelPackages.v4l2loopback.overrideAttrs (old: {
      # NixOS runs depmod after combining all kernel modules.
      makeFlags = (old.makeFlags or [ ]) ++ [ "DEPMOD=true" ];
    }))
  ];

  boot.kernelModules = [ "v4l2loopback" ];

  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
  '';

  security.polkit.enable = true;

  environment.systemPackages = with pkgs; [ obs-studio ];
}
