{ config, lib, pkgs, ... }:
let minecraft-optirun = pkgs.writeShellScriptBin "minecraft-optirun" ''
  ${pkgs.steam-run}/bin/steam-run ${pkgs.bumblebee}/bin/optirun ${pkgs.minecraft}/bin/minecraft;
'';
in
{
  networking.hostName = "wayfarer";
  
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.efiSysMountPoint = "/boot";

  services.autorandr.enable = true;

  boot.initrd.luks.devices = [{
    name = "root";
    device = "/dev/sda2";
    preLVM = true;
  }];

  powerManagement.powerUpCommands = ''
    ${pkgs.hdparm}/sbin/hdparm -Y /dev/sdb
    setxkbmap --options ctrl:nocaps
  '';

  environment.systemPackages = with pkgs; [
    autorandr
    minecraft-optirun
  ];

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.03"; # Did you read the comment?


  
}
