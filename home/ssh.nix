{ ... }:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
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
