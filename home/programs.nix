{ pkgs, ... }:
{
  accounts.email.accounts.purelymail = {
    primary = true;
    address = "nika@nikableh.moe";
    userName = "nika@nikableh.moe";
    realName = "Nika Krasnova";
    passwordCommand = "${pkgs.pass}/bin/pass show email/purelymail";
    smtp = {
      host = "smtp.purelymail.com";
      port = 465;
      tls = {
        enable = true;
        useStartTls = false;
      };
    };
    msmtp.enable = true;
  };

  programs = {
    bash.enable = true;
    neovim.enable = true;
    direnv.enable = true;
    gpg.enable = true;
    msmtp.enable = true;

    git = {
      enable = true;
      package = pkgs.gitFull;
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
        sendemail = {
          smtpServer = "${pkgs.msmtp}/bin/msmtp";
          from = "Nika Krasnova <nika@nikableh.moe>";
          confirm = "auto";
          annotate = true;
        };
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
