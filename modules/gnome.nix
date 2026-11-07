{
  config,
  lib,
  pkgs,
  ...
}:

{

  services = {
    desktopManager.gnome.enable = true;
  };

  environment = {
    systemPackages = with pkgs; [
      ddcutil-service
      egl-wayland
      gnome-tweaks
      gnomeExtensions.alphabetical-app-grid
      gnomeExtensions.blur-my-shell
      gnomeExtensions.caffeine
      gnomeExtensions.dash-to-dock
      gnomeExtensions.just-perfection
    ];
  };

}
