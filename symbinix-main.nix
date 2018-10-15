{ config, pkgs, hostName,... }:
{
  imports = [
    ./hardware-configuration-symbinix.nix
    ./modules/common.nix
    ./modules/desktop.nix
    ./modules/docker.nix
    ./modules/symbinix.nix
    ./modules/hie.nix
    ./modules/haskell.nix
    ./modules/scripts.nix
  ];
}
