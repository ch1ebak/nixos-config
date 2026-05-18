# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [
      /etc/nixos/hardware-configuration.nix
    ];

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 15d";
    };
  };
  
  nixpkgs = {
    config = {
      allowUnfree = true;
			permittedInsecurePackages = ["nexusmods-app-0.21.1"];
    };
  };

	boot = {
		kernelPackages = pkgs.linuxPackages_latest;
		loader = {
			systemd-boot.enable = true;
			efi.canTouchEfiVariables = true;
		};
	};

  # Nvidia
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = true;

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
		printing.enable = true;
		libinput.enable = true;
		pipewire = {
			enable = true;
			pulse.enable = true;
		};
		syncthing = {
			enable = true;
			openDefaultPorts = true;
		};
	};

	# Fonts
  fonts = {
    packages = with pkgs; [
      atkinson-hyperlegible
			cantarell-fonts
      nerd-fonts.jetbrains-mono
    ];
		fontconfig = {
			enable = true;
			defaultFonts = {
				monospace = ["JetBrainsMono NF"];
				serif = ["JetBrainsMono NF"];
				sansSerif = ["Atkinson Hyperlegible"];
			};
		};
  };

	# XDG Portals
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    config.common.default = "*";
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
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
	};

	# Packages
  environment.systemPackages = with pkgs; [
		acpilight
		brightnessctl
		btop
		calibre
		capitaine-cursors
		clamav
		cliphist
		dunst
		easyeffects
		egl-wayland
		emacs
		fastfetch
		fd
		feh
		ferdium
		file-roller
		firefox
		fzf
		ghostty
		git
		gh
		grim
		gvfs
		harper
		heroic
		hypridle
		hyprlock
		imagemagick
		libnotify
		lsp-plugins
		mpv
		neovim
		networkmanagerapplet
		nexusmods-app
		nordic
		nwg-look
		papirus-icon-theme
		pcmanfm
		polkit
		polkit_gnome
		protontricks
		qbittorrent
		rawtherapee
		ripgrep
		rofi
		stow
		swaybg
		syncthing
		trash-cli
		vial
		waves
		waybar
		wget
		wine-staging
		xdg-utils
		yazi
		yt-dlp
		zoxide
  ];

	# DO NOT CHANGE
  system.stateVersion = "25.11";

}

