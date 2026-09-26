{
  config,
  lib,
  pkgs,
  ...
}:

{

  services.desktopManager.gnome.enable = true;

  environment = {
    systemPackages = with pkgs; [
      gnome-tweaks
      gnomeExtensions.auto-move-windows
      gnomeExtensions.dash-to-dock
      gnomeExtensions.just-perfection
      gnomeExtensions.vitals
    ];
  };

}
