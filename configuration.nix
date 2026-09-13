#
# ░███    ░██ ░██             ░██████     ░██████
# ░████   ░██                ░██   ░██   ░██   ░██
# ░██░██  ░██ ░██░██    ░██ ░██     ░██ ░██
# ░██ ░██ ░██ ░██ ░██  ░██  ░██     ░██  ░████████
# ░██  ░██░██ ░██  ░█████   ░██     ░██         ░██
# ░██   ░████ ░██ ░██  ░██   ░██   ░██   ░██   ░██
# ░██    ░███ ░██░██    ░██   ░██████     ░██████
#
# github.com/ch1ebak

{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    /etc/nixos/hardware-configuration.nix
    /home/karna/.nixos-btw/modules/packages.nix
    /home/karna/.nixos-btw/modules/wayland.nix
    /home/karna/.nixos-btw/modules/gaming.nix
    /home/karna/.nixos-btw/modules/dev.nix
    # /home/karna/.nixos-btw/modules/xorg.nix
    # /home/karna/.nixos-btw/modules/vm.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
      efi.canTouchEfiVariables = true;
    };
    kernelParams = [
      "acpi_backlight=native"
      "i915.enable_dpcd_backlight=1"
    ];
    initrd.kernelModules = [
      "nvidia"
      "nvidia_modeset"
      "nvidia_uvm"
      "nvidia_drm"
    ];
    extraModprobeConfig = ''
      		options nvidia_drm modeset=1
      		'';
  };

  environment = {
    sessionVariables = {
      LD_LIBRARY_PATH = "/run/opengl-driver/lib:/run/opengl-driver-32/lib btop"; # fixes nvidia in btop
      QT_QPA_PLATFORMTHEME = "qt6ct";
      # nvidia
      LIBVA_DRIVER_NAME = "nvidia";
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    };
  };

  hardware = {
    acpilight.enable = true;
    i2c.enable = true;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    nvidia = {
      open = true;
      modesetting.enable = true;
      prime = {
        offload.enable = true;
        offload.enableOffloadCmd = true;
        intelBusId = "PCI:0@0:2:0";
        nvidiaBusId = "PCI:1@0:0:0";
      };
    };
  };

  i18n.defaultLocale = "pl_PL.UTF-8";

  networking = {
    hostName = "nixos-btw";
    networkmanager.enable = true;
  };

  nix = {
    settings = {
      warn-dirty = false;
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  time.timeZone = "Europe/Warsaw";

  users.users.karna = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "libvirtd"
      "dialout"
      "tty"
    ];
  };

  # DO NOT CHANGE
  system.stateVersion = "25.11";

}
