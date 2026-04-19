{ pkgs, ... }:
{
  programs = {
    bash.enable = true;
    neovim.enable = true;
    direnv.enable = true;
    gpg.enable = true;

    claude-code = {
      enable = true;
      settings = {
        includeCoAuthoredBy = false;
        enabledPlugins = {
          "rust-analyzer-lsp@claude-plugins-official" = true;
          "caveman@caveman" = true;
        };
        statusLine = {
          type = "command";
          command = "bash \"/home/nikableh/.claude/plugins/marketplaces/caveman/hooks/caveman-statusline.sh\"";
        };
        extraKnownMarketplaces = {
          caveman = {
            source = {
              source = "github";
              repo = "JuliusBrussee/caveman";
            };
            autoUpdate = true;
          };
        };
        hooks = {
          Notification = [
            {
              matcher = "";
              hooks = [
                {
                  type = "command";
                  command = "nix-shell -p libnotify.out --run 'notify-send \"Claude\" \"Waiting for your input\"'";
                }
              ];
            }
          ];
        };
      };
    };

    git = {
      enable = true;
      lfs.enable = true;
      settings = {
        user.name = "Nika Krasnova";
        user.email = "nika@nikableh.moe";
        user.signingKey = "90AB07612815096E";
        init.defaultBranch = "main";
        gpg.format = "openpgp";
        commit.gpgsign = true;
        tag.gpgSign = true;
        core.editor = "nvim";
        diff.tool = "meld";
      };
    };
  };

  services = {
    copyq.enable = true;

    gpg-agent = {
      enable = true;
      enableSshSupport = true;
      pinentry.package = pkgs.pinentry-gnome3;
      defaultCacheTtl = 86400;
      maxCacheTtl = 86400;
      defaultCacheTtlSsh = 86400;
      maxCacheTtlSsh = 86400;
    };
  };
}
