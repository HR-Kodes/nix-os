# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ../../system/hardware-configuration.nix

      ../../system/hardware/kernel.nix  # Kernel config
      ../../system/hardware/opengl.nix 
      ../../system/hardware/power.nix
      ../../system/hardware/printing.nix
      # ../../system/hardware/bluetooth.nix
      ../../system/hardware/time.nix  # Network time sync

      ../../system/security/firewall.nix
      ../../system/security/gpg.nix

      ../../system/wm/hyprland.nix
    ];

  nix.nixPath = [ "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
                  "nixos-config=$HOME/dotfiles/system/configuration.nix"
                  "/nix/var/nix/profiles/per-user/root/channels"
                ];

  # Ensure nix flakes are enabled
  nix.package = pkgs.nixFlakes;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # Bootloader -> Enabling GRUB.
  boot.loader.systemd-boot.enable = false;
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";


  # Bootloader -> Setting kernel.
  boot.kernelModules = [ "v4l2loopback" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];


  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];



  # FISH -> Setting default shell to fish.
  environment.shells = with pkgs; [ bash fish zsh ];
  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;
  programs.zsh.interactiveShellInit = ''eval "$(direnv hook zsh"'';
  programs.fish.interactiveShellInit = ''eval "$(direnv hook fish)"'';



  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };


  # SDDM -> Enabling login manager
  # services.xserver.enable = true;
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.displayManager.sddm.wayland.enable = true;
  # services.xserver.displayManager.sddm.theme = "where_is_my_sddm_theme";


  # Desktop portals -> Enabling with gtk or hyprland.
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ 
    # pkgs.xdg-desktop-portal-hyprland
    pkgs.xdg-desktop-portal
    pkgs.xdg-desktop-portal-gtk
  ];

  # Touchpad -> Enabling touchpad support.
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.koushikhr = {
    isNormalUser = true;
    description = "Koushik H R";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = (pkg: true);

  # Enabling thunar file manager.
  programs.thunar.enable = true;

  environment.systemPackages = with pkgs; [
    sddm
    hyprland
    xwayland
    waybar
    xdg-desktop-portal-hyprland
    networkmanagerapplet
    wget
    wpa_supplicant
    pipewire
    gitFull
    # Packages Related -> Development
    gcc
    libstdcxx5
    zig

    kitty
    neovim
    google-chrome
  ];

  environment.sessionVariables = {
    MOZ_USE_XINPUT2 = "1";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
  nix = {
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  environment.variables={
   NIXOS_OZONE_WL = "1";
   PATH = [
     "\${HOME}/.local/bin"
     "\${HOME}/.cargo/bin"
     "\$/usr/local/bin"
   ];
   NIXPKGS_ALLOW_UNFREE = "1";
   SCRIPTDIR = "\${HOME}/.local/share/scriptdeps";
   STARSHIP_CONFIG = "\${HOME}/.config/starship/starship.toml";
   XDG_CURRENT_DESKTOP = "Hyprland";
   XDG_SESSION_TYPE = "wayland";
   XDG_SESSION_DESKTOP = "Hyprland";
   GDK_BACKEND = "wayland";
   CLUTTER_BACKEND = "wayland";
   SDL_VIDEODRIVER = "x11";
   XCURSOR_SIZE = "24";
   XCURSOR_THEME = "Bibata-Modern-Ice";
   QT_QPA_PLATFORM = "wayland";
   QT_QPA_PLATFORMTHEME = "qt5ct";
   QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
   QT_AUTO_SCREEN_SCALE_FACTOR = "1";
   MOZ_ENABLE_WAYLAND = "1";
  };

  # nix.settings.experimental-features = "nix-command flakes";

}
