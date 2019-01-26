{ config, lib, pkgs, ... }:
let 
  redacted = import /root/redacted.nix;
in {
  networking.networkmanager = {
    enable = true;
  };
  #networking.supplicant."wlp0s20u2" = {
  #  userControlled = {
  #    enable = true;
  #  };
  #};
  #networking.wireless = {
  #  # Enables wireless support via wpa_supplicant.
  #  enable = true;
  #  networks = redacted.networks;
  #};
}



