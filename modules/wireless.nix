let 
  redacted = import /root/redacted.nix;
in {
  networking.wireless = {
    # Enables wireless support via wpa_supplicant.
    enable = hostName == "wayfarer";  
    networks = redacted.networks;
  };
}



