# ----- * NixOS Default Config* - base.nix ----- 

{ config, pkgs, ... }:
{
  # Variables
    environment.sessionVariables = {
      FLAKE = "/home/ca/.config/nixos";
    };

  # Use the systemd-boot EFI boot loader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Network Settings
    networking.wireless.networks = {
      "(HM777)".priority = true;
    };  

  # Set your time zone.
    time.timeZone = "America/Chicago";

  # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_INDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };

  # Enable X11 and Desktop Environment
    services.xserver = {
      enable = true;
      autorun = false;
      libinput = {
        touchpad.naturalScrolling = true;
        mouse.naturalScrolling = true;
      };
      displayManager = {
        gdm.enable = true;
        sessionCommands = ''
          ${pkgs.sxhkd}/bin/sxhkd &
        '';
      };  
      desktopManager = {
        gnome.enable = true;
        wallpaper.mode = "fill";
      };
      windowManager.qtile.enable = true;
      xkb = {
        layout = "us";
        variant = "";
        options ="caps:escape";
      };
      excludePackages = with pkgs; [
        xterm
      ];
    };

  # Enable the OpenSSH daemon.
   services.openssh.enable = true;

  # Enable CUPS to print documents.
    services.printing.enable = true;

  # Enable Bluetooth
    hardware.bluetooth.enable = true;
  
  # Enable sound.
    sound.enable = true;
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

  # Define a user account. 
    users.users.ca = {
      isNormalUser = true;
      extraGroups = [ "sudo" "networkManager" "wheel" ]; 
    };

  # Allow unfree packages
    nixpkgs.config = {
      allowUnfree = true;
    };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
    environment.systemPackages = with pkgs; [
      wget
      tree
      git
      gh
      sxhkd
      feh
      neovim
      fish
      vifm
      rofi
      rofimoji
      trash-cli
      vivaldi
      obsidian
      audacity 
      kitty
      fzf
      fd
      btop
      eza
      ripgrep
      ffmpeg
      flameshot
      nh
      nix-output-monitor
      nvd
      pavucontrol
      libqalculate
      bluez
      bluez-tools
      bluetuith
      zathura
      vlc
      yt-dlp
      audacity
      dunst
      mpv
      flatpak
      obs-studio
      pcmanfm
      rsync
      gimp
      fastfetch
      remmina
      unzip
    ];

  # Fonts
    fonts.packages = with pkgs; [
    ];
  
  # Excluded Gnome Packages
    environment.gnome.excludePackages = 
      (with pkgs; [gnome-photos gnome-tour gedit]) 
      ++ (with pkgs.gnome; [baobab cheese eog epiphany simple-scan totem tali iagno hitori atomix yelp evince file-roller seahorse gnome-calculator gnome-calendar gnome-characters gnome-contacts gnome-font-viewer gnome-logs gnome-music gnome-screenshot gnome-system-monitor gnome-weather gnome-disk-utility pkgs.gnome-connections gnome-terminal 
      ]);

  # DO NOT ALTER OR DELETE
    system.stateVersion = "24.05";
}
