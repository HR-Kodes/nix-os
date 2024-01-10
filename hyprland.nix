{ config, lib, pkgs, ... }:

{

  imports = [
    ./wayland.nix
    ./pipewire.nix
    ./dbus.nix
  ];

  programs = {
    hyprland = {
      enable = true;
      xwayland = {
        enable = true;
      };
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
    };

    waybar.enable = true;
    nm-applet.enable = true;
  };

  # xdg.portal,enable = true;
  # xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];

}
