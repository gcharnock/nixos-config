{ config, lib, pkgs, ... }:

{

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "nodev";

  boot.initrd.luks.devices = [{
    name = "root";
    device = "/dev/sda2";
    preLVM = true;
  }];

  networking = {
    hostName = "symbinix";

    # I need to stop procrastinating. 
    hosts = {
      "127.0.0.1" = [
        "bbc.co.uk" 
        "www.bbc.co.uk" 
        "reddit.com" 
        "www.reddit.com" 
      ];
    };
    nameservers = [
      "10.32.1.2"
      "172.20.1.9"
      "10.32.1.1"
    ];
    firewall.enable = false;
  };


  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.03"; # Did you read the comment?

}


