{ config, lib, pkgs, ... }:

{

  imports = [
    ./pipewire.nix
    ./dbus.nix
    # ./fonts.nix
  ];

  environment.systemPackages = [ pkgs.wayland pkgs.waydroid ];

  # Configure xwayland.
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
    # xkbOptions = "caps:escape";
    displayManager.sddm = {
      enable = true;
      theme = "abstractdark-sddm-theme";
      autoNumlock = true;
    };
  };


}
