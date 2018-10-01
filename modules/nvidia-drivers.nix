{ config, lib, pkgs, ... }:
{
  imports = [ ];

  hardware.opengl = {
    driSupport = true;
  };
  hardware.bumblebee.enable = true;


  services.xserver.videoDrivers = [
    "intel"
    "vesa"
    "modesetting" 
  ];
}
