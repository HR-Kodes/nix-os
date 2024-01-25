{ lib, pkgs, config, ... }:

{
  home.packages = with pkgs; [
    direnv
    gcc gnumake cmake autoconf automake libtool # cc Programming
    rustup # Rust Programming
    # nodejs corepack_latest # Web Development
  ];
  }
