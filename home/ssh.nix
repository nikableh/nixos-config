{ ... }:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "yodh" = {
        hostname = "192.168.1.42";
        user = "user";
        identityFile = "~/.ssh/nikableh";
        IdentitiesOnly = "yes";
      };
      "github" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/nikableh";
        AddKeysToAgent = "yes";
      };
      "mytona" = {
        hostname = "git.mytona.com";
        user = "git";
        identityFile = "~/.ssh/mytona";
        AddKeysToAgent = "yes";
      };
    };
  };
}
