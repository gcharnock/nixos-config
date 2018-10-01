# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

let
in
{ config, pkgs, hostName,... }:
{
  imports =
    if hostName == "wayfarer"
      then [
        ./hardware-configuration-wayfarer.nix
	./modules/common.nix
	./modules/desktop.nix
	./modules/hie.nix
	./modules/nvidia-drivers.nix
	./modules/wireless.nix
      ]
      else [
        ./hardware-configuration-symbinix.nix
	./modules/common.nix
	./modules/desktop.nix
	./modules/docker.nix
	./modules/symbinix.nix
      ] ;


  networking.hostName = hostName; # Define your hostname.

}
