{ config, lib, pkgs, ... }:

{

  nixpkgs.config.permittedInsecurePackages = [ "nexusmods-app-unfree-0.21.1" ];

  programs = {
    gamemode.enable = true;
    gamescope.enable = true;
    steam = {
      enable = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };
  };

  environment = {
    systemPackages = with pkgs; [
      lutris
      mangohud
      nexusmods-app-unfree
    ];
  };

}
