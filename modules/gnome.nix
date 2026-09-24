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
    ];
  };

}
