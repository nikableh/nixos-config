{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ keyd ];
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ];
        settings = {
          main = {
            f23 = "f21";
          };
          otherlayer = { };
        };
      };
    };
  };
}
