{ inputs, pkgs, ... }:
{
  users.users = {
    nikableh = {
      isNormalUser = true;
      extraGroups = [
        "networkmanager"
        "wheel"
        "kvm"
        "render"
        "adbusers"
      ];
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };

    users = {
      nikableh = {
        imports = [
          inputs.codex-desktop-linux.homeManagerModules.default

          ./packages.nix
          ./programs.nix
          ./environment.nix
          ./gnome.nix
          ./ssh.nix

          ./git-hooks
          ./scripts
        ];

        programs.codexDesktopLinux = {
          enable = true;
          linuxFeatures = [
            "computer-use-linux"
            "appshots"
            "global-dictation"
            "read-aloud"
            "read-aloud-mcp"
            "directory-only-working-tree-watch"
            "linux-performance-workarounds"
            "mcp-helper-reaper"
            "node-repl-reaper"
            "automation-extensions"
            "persistent-status-panel"
            "tray-usage"
          ];
        };

        home.packages = [ pkgs.bubblewrap ];

        systemd.user.startServices = "sd-switch";

        home.stateVersion = "25.11";
      };
    };
  };
}
