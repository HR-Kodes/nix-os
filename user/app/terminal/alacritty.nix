{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    alacritty
  ];

  programs.alacritty.enable = true;
  programs.alacritty.settings = {
    window.opacity = lib.mkForce 0.65;

    font = {
      # normal.family = config.themes.fonts.mono.family;
      # size = config.themes.fonts.mono.size;
      # bold = { style = "Bold"; };
    };

    window.padding = {
      x = 2;
      y = 2;
    };

    cursor.style = "Beam";

    colors = {
      primary = {
        # background = "#000000";
	# foreground = "#ffffff";
      };
    };

  };
}
