{ config, pkgs, ... }:

{
  # Firewall
  networking.firewall.enable = true;
  
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  # Or disable the firewall altogather.
  # networking.firewall.enable = false;
}