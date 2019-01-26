{ config, pkgs, hostName,... }:
{
  imports = [
    ./hardware-configuration-wayfarer.nix
    ./modules/wayfarer.nix
    ./modules/common.nix
    ./modules/desktop.nix
    ./modules/hie.nix
    ./modules/nvidia-drivers.nix
    ./modules/wireless.nix
    ./modules/haskell.nix
    ./modules/scripts.nix
    ./modules/automount.nix
  ];
}

