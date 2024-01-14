{ config, lib, pkgs, ... }:

{

  imports = [
    ./pipewire.nix
    ./dbus.nix
    # ./fonts.nix
  ];

  environment.systemPackages = [ pkgs.wayland pkgs.waydroid ];

  ## Configure xwayland.
  # services.xserver = {
  #   enable = true;
  #   layout = "us";
  #   xkbVariant = "";
  #   # xkbOptions = "caps:escape";
  #   displayManager.sddm = {
  #     enable = true;
  #     theme = "abstractdark-sddm-theme";
  #     autoNumlock = true;
  #   };
  # };

  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.sddm.wayland.enable = true;
  services.xserver.displayManager.sddm.theme = "where_is_my_sddm_theme";


}
