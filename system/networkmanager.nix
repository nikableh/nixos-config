{ pkgs, ... }:
{
  # With connectivity probes disabled, NetworkManager 1.58.1 can keep reporting
  # LIMITED after a default route appears. Refresh the inferred state on IP
  # configuration changes so GNOME does not retain the no-internet icon.
  networking.networkmanager.package = pkgs.networkmanager.overrideAttrs (old: {
    patches = (old.patches or [ ]) ++ [ ./patches/networkmanager-refresh-route-connectivity.patch ];
  });
}
