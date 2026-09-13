{
  config,
  lib,
  pkgs,
  ...
}:

{

  programs = {
    dconf = {
      enable = true;
      profiles.user.databases = [
        {
          settings."org/gnome/desktop/interface" = {
            gtk-theme = "adw-gtk3-dark";
            icon-theme = "Adwaita";
            cursor-theme-name = "capitaine-cursors-white 15";
            font-name = "Atkinson Hyperlegible 10";
            document-font-name = "Atkinson Hyperlegible 10";
            monospace-font-name = "JetBrainsMono Nerd Font 10";
          };
        }
      ];
    };
  };

  services = {
    displayManager.ly.enable = true;
    flatpak.enable = true;
    fstrim.enable = true;
    gvfs.enable = true;
    libinput.enable = true;
    power-profiles-daemon.enable = true;
    udisks2.enable = true;
    upower.enable = true;
    xserver.videoDrivers = [ "nvidia" ];
    udev = {
      packages = with pkgs; [
        vial
      ];
      extraRules = ''
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

  environment = {
    systemPackages = with pkgs; [
      adwaita-icon-theme
      brave-origin
      brightnessctl
      btop
      calibre
      capitaine-cursors
      ddcutil
      easyeffects
      fastfetch
      fd
      feh
      ferdium
      file-roller
      fzf
      ghostty
      killall
      libnotify
      lsp-plugins
      mpd
      mpdscribble
      mpv
      neovim
      nwg-look
      obsidian
      pcmanfm
      polkit
      polkit_gnome
      protontricks
      qbittorrent
      rawtherapee
      ripgrep
      rmpc
      rofi
      stow
      syncthing
      trash-cli
      wget
      wineWow64Packages.stable
      xdg-utils
      yazi
      yt-dlp
      zmk-studio
      zoxide
    ];
  };

  fonts = {
    packages = with pkgs; [
      atkinson-hyperlegible
      cantarell-fonts
      nerd-fonts.jetbrains-mono
      noto-fonts
    ];
  };

  security.polkit.enable = true;

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

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

}
