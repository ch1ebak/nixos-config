{ config, lib, pkgs, ... }:

{
  imports =
    [
      /etc/nixos/hardware-configuration.nix
    ];

  nix = {
    settings = {
			warn-dirty = false;
			auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
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
			permittedInsecurePackages = [ "nexusmods-app-unfree-0.21.1" ];
    };
  };

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
		initrd.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
		extraModprobeConfig = ''
		options nvidia_drm modeset=1
		'';
	};

  # Hardware
	hardware = {
		acpilight.enable = true;
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

  # Timezone
  time.timeZone = "Europe/Warsaw";

	# Locale
  i18n.defaultLocale = "pl_PL.UTF-8";

	# Network
  networking = {
		hostName = "nixos-btw";
		networkmanager.enable = true;
	};

  # User
  users.users.karna = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };

	# Services
	services = {
		displayManager.ly.enable = true;
		udisks2.enable = true;
		gvfs.enable = true;
		libinput.enable = true;
		flatpak.enable = true;
    picom.enable = true;
		xserver = {
			videoDrivers = [
        "modesetting"
			 	"nvidia"
			];
		};
		udev = {
			packages = with pkgs; [
				vial
			];
			extraRules =
			''
			ENV{ID_VENDOR_ID}=="046d", ENV{ID_MODEL_ID}=="0825", ENV{PULSE_IGNORE}="1"
			'';
		};
		pipewire = {
			enable = true;
			pulse.enable = true;
			alsa.enable = true;
			alsa.support32Bit = true;
			wireplumber.enable = true;
		};
		syncthing = {
			enable = true;
			openDefaultPorts = true;
			user = "karna";
			configDir = "/home/karna/.config/syncthing";
		};
	};

	# Fonts
  fonts = {
    packages = with pkgs; [
      atkinson-hyperlegible
			cantarell-fonts
			noto-fonts
      nerd-fonts.jetbrains-mono
    ];
  };

	# XDG Portals
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
    ];
    config = {
      common.default = "gtk";
    };
    xdgOpenUsePortal = false;
  };

	# Polkit
	security.polkit.enable = true;

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = ["graphical-session.target"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

	# Programs
  programs = {
		mango.enable = true;
		steam = {
			enable = true;
			extraCompatPackages = with pkgs; [
				proton-ge-bin
			];
		};
		dconf = {
			enable = true;
			profiles.user.databases = [
				{
					settings."org/gnome/desktop/interface" = {
						gtk-theme = "Nordic-darker";
						icon-theme = "Papirus-Dark";
						cursor-theme-name = "capitaine-cursors-white";
						font-name = "Atkinson Hyperlegible 10";
						document-font-name = "Atkinson Hyperlegible 10";
						monospace-font-name = "JetBrainsMono Nerd Font 10";
					};
				}
			];
		};
	};

	# Packages
  environment = {
		sessionVariables = {
			LD_LIBRARY_PATH="/run/opengl-driver/lib:/run/opengl-driver-32/lib btop"; # fixes nvidia in btop
      QT_QPA_PLATFORMTHEME = "qt6ct";
      # nvidia
      LIBVA_DRIVER_NAME = "nvidia";
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
		};
		systemPackages = with pkgs; [
			brightnessctl
			btop
			calibre
			capitaine-cursors
			cliphist
			dunst
			easyeffects
			egl-wayland
			emacs
			fastfetch
			fd
			feh
			file-roller
			fzf
			git
			gh
			grim
			harper
			heroic
			hypridle
			hyprlock
			imagemagick
			killall
			libnotify
			lsp-plugins
      mpd
      mpdscribble
			mpv
			neovim
			networkmanagerapplet
			nexusmods-app-unfree
			nordic
			nwg-look
			pandoc
			papirus-icon-theme
			pcmanfm
			polkit
			polkit_gnome
			protontricks
			rawtherapee
			ripgrep
      rmpc
			rofi
			stow
			swaybg
			syncthing
			trash-cli
			vial
			waybar
			wezterm
			wget
			wine-staging
			xdg-utils
			yazi
			yt-dlp
			zoxide
		];
	};

	# DO NOT CHANGE
  system.stateVersion = "25.11";

}
