{ ... }:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "github" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/nikableh";
        extraOptions.AddKeysToAgent = "yes";
      };
      "mytona" = {
        hostname = "git.mytona.com";
        user = "git";
        identityFile = "~/.ssh/mytona";
        extraOptions.AddKeysToAgent = "yes";
      };
    };
  };
}
