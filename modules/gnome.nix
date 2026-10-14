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
      gnomeExtensions.blur-my-shell
      gnomeExtensions.just-perfection
      gnome-tweaks
    ];
  };

  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

}
