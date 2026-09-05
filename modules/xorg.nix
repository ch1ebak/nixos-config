{ config, lib, pkgs, ... }:

{

  services = {
    picom.enable = true;
    xserver = {
      enable = true;
      autoRepeatDelay = 200;
      autoRepeatInterval = 35;
      windowManager = {
        oxwm.enable = true;
      };
    };
  };


  environment = {
    systemPackages = with pkgs; [
      scrot
      slock
      xclip
    ];
  };

}


