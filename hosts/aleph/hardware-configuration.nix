{
  config,
  lib,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd.availableKernelModules = [
      "xhci_pci"
      "thunderbolt"
      "nvme"
      "usb_storage"
      "sd_mod"
      "sdhci_pci"
    ];
    initrd.kernelModules = [ ];
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];

    # Chainload Windows from its own ESP (nvme0n1p1, FS UUID 7CC4-56C8).
    loader.systemd-boot = {
      edk2-uefi-shell.enable = true;
      windows."11" = {
        title = "Windows 11";
        efiDeviceHandle = "HD0b";
      };
    };
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/2b611c7e-5636-4bc4-ad2a-18ef8135dde8";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/79DD-D7DE";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.npu.enable = true;
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  services.udev = {
    # Don't allow the Wi-Fi adapter (8086:272b) to enter D3cold.
    extraRules = ''
      ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x8086", ATTR{device}=="0x272b", ATTR{d3cold_allowed}="0"
    '';

    # The EC sends the PS/2 "Wake" scancode (e0 63, MSC_SCAN e3) right after
    # every Super press. Mutter only opens the overview when Super is the
    # only key between its press and release, so that phantom key kills the
    # bare Super binding. Drop it.
    extraHwdb = ''
      evdev:atkbd:dmi:bvn*:bvr*:bd*:svnLENOVO*:pn83JK*:pvr*
       KEYBOARD_KEY_e3=reserved

      # ideapad-laptop reports KEY_SELECTIVE_SCREENSHOT for the screenshot
      # key without Fn. Map it to KEY_SYSRQ, which GNOME handles as Print.
      # TODO: Upstream a fix for KEY_SELECTIVE_SCREENSHOT handling and remove
      # this local workaround once the key works in GNOME without remapping.
      evdev:name:Ideapad extra buttons:dmi:bvn*:bvr*:bd*:svnLENOVO*:pn83JK:*
       KEYBOARD_KEY_12d=sysrq
    '';
  };
}
