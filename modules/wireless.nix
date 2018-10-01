{ config, lib, pkgs, ... }:
let 
  redacted = import /root/redacted.nix;
in {
  networking.wireless = {
    # Enables wireless support via wpa_supplicant.
    enable = true;
    networks = redacted.networks;
  };
}



