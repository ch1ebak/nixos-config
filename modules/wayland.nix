{ config, lib, pkgs, ... }:

{

  programs.mango.enable = true;

  environment = {
    systemPackages = with pkgs; [
      cliphist
      egl-wayland
      grim
      noctalia
    ];
  };

}


