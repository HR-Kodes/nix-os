{ config, pkgs, ... }:

{
    services.samba-wsdd = {
  # make shares visible for Windows clients
  enable = true;
  openFirewall = true;
};
services.samba = {
  enable = true;
  securityType = "user";
  extraConfig = ''
    workgroup = WORKGROUP
    server string = smbnix
    netbios name = smbnix
    security = user 
    #use sendfile = yes
    #max protocol = smb2
    # note: localhost is the ipv6 localhost ::1
    hosts allow = 192.168.0. 127.0.0.1 localhost
    hosts deny = 0.0.0.0/0
    guest account = nobody
    map to guest = bad user
  '';
  shares = {
    public = {
      path = "/mnt/Shares/Public";
      browseable = "yes";
      "read only" = "no";
      "guest ok" = "yes";
      "create mask" = "0644";
      "directory mask" = "0755";
      "force user" = "username";
      "force group" = "groupname";
    };
    private = {
      path = "/mnt/Shares/Private";
      browseable = "yes";
      "read only" = "no";
      "guest ok" = "no";
      "create mask" = "0644";
      "directory mask" = "0755";
      "force user" = "username";
      "force group" = "groupname";
    };
  };
};

# networking.firewall.enable = true;
networking.firewall.allowPing = true;
services.samba.openFirewall = true;
# networking.firewall.allowedTCPPorts = [ 445 139 ];
# networking.firewall.allowedUDPPorts = [ 137 138 ];
  }
