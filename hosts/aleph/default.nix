{
  imports = [ ./hardware-configuration.nix ];

  networking.hostName = "aleph";

  # Chainload Windows from its own ESP (nvme0n1p1, FS UUID 7CC4-56C8).
  boot.loader.systemd-boot = {
    edk2-uefi-shell.enable = true;
    windows."11" = {
      title = "Windows 11";
      efiDeviceHandle = "HD0b";
    };
  };

  # Don't allow the Wi-Fi adapter (8086:272b) to enter D3cold.
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x8086", ATTR{device}=="0x272b", ATTR{d3cold_allowed}="0"
  '';

  system.stateVersion = "26.05";
}
