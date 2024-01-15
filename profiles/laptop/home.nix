{ lib, config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  
  home.username = "koushikhr";
  home.homeDirectory = "/home/koushikhr";

  home.stateVersion = "23.11"; # Please read the comment before changing.

  imports = [
    ../../user/app/terminal/alacritty.nix # My alacritty config
    # ../../user/app/terminal/alacritty.yml
    ../../user/app/browsers/firefox-dev.nix
    ../../user/app/vscodium/vscodium.nix
    ../../user/hardware/bluetooth.nix  # Bluetooth
    ../../user/wm/hyprland/waybar.nix
  ];

  home.packages = with pkgs; [
    qutebrowser alacritty rofi-wayland avizo grim swappy slurp
    libnotify swaynotificationcenter pavucontrol gnome.file-roller unrar unzip 
    swww imv v4l-utils ydotool pkg-config wl-clipboard lsd transmission-gtk mpv
    nerdfonts font-awesome symbola noto-fonts-color-emoji material-icons

    (import ../../scripts/emopicker9000.nix { inherit pkgs; })
    (import ../../user/bin/task-waybar.nix { inherit pkgs; })
    (import ../../user/bin/wallsetter.nix { inherit pkgs; })

    # Development Related packages
    fd lazygit ripgrep# Dependencies Neovim - Lazy.Vim Distro
    rustup # Rust Programming
    gcc gnumake cmake autoconf automake libtool # cc Programming
    nodejs corepack_latest # Web Development

  ];


  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };

  qt.enable = true;
  qt.platformTheme = "gtk";
  qt.style.name = "adwaita-dark";
  qt.style.package = pkgs.adwaita-qt;
  gtk = {
    enable = true;
    font = {
      name = "Ubuntu";
      size = 12;
      package = pkgs.ubuntu_font_family;
    };
    theme = {
      name = "Tokyonight-Storm-BL";
      package = pkgs.tokyo-night-gtk;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
    };


    gtk3.extraConfig = {
      Settings = ''
      gtk-application-prefer-dark-theme=1
      '';
    };
    gtk4.extraConfig = {
      Settings = ''
      gtk-application-prefer-dark-theme=1
      '';
    };
  };

  xdg = {
    userDirs = {
        enable = true;
        createDirectories = true;
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    profileExtra = ''
      #if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
      #  exec Hyprland
      #fi
    '';
    sessionVariables = {
    
    };
    shellAliases = {
      sv="sudo nvim";
      # flake-rebuild="sudo nixos-rebuild switch --flake ~/zaneyos/#workstation";
      # laptop-rebuild="sudo nixos-rebuild switch --flake ~/zaneyos/#laptop";
      v="nvim";
      ls="lsd";
      ll="lsd -l";
      la="lsd -a";
      lal="lsd -al";
      ".."="cd ..";
    };
  };



  home.file = {

    ".config/hypr/hyprland.conf".source = ../../user/wm/hyprland/hyprland.conf;

    # ".local/share/fonts" = {
    #   source = ../../fonts;
    #   recursive = true;
    # };

    ".emoji".source = ../../user/emoji;

    
    ".config/rofi" = {
      source = ../../user/app/rofi;
      recursive = true;
    };

    ".config/alacritty/alacritty.yml".source = ../../user/app/terminal/alacritty.yml;

    # ".alacritty.yml".source = ../../user/app/terminal/alacritty.yml;

    ".config/swaync" = {
      source = ../../user/app/swaync;
      recursive = true;
    };
    
    "Pictures/Wallpapers" = {
      source = ../../themes/wallpapers;
      recursive = true;
    };

    ".config/avizo/config.ini" = {
      source = ../../user/app/avizo/config.ini;
    };

    “.config/nvim”.source = config.lib.file.mkOutOfStoreSymlink ~/.dotfiles/user/app/nvim;

  };

  fonts.fontconfig.enable = true;

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Configuring git.
  programs.git = {
    enable = true;
    userName = "Koushik H R";
    userEmail = "koushikhr1441@gmail.com";
  };

  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    };

}
