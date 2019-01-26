{ config, lib, pkgs, ... }:
{
  imports = [ ];

  hardware.opengl = {
    driSupport = true;
    driSupport32Bit = true;
  };
  hardware.bumblebee.enable = true;


  services.xserver.videoDrivers = [
    "intel"
    "vesa"
    "modesetting" 
  ];


  environment.systemPackages = with pkgs; [
     steam
     steam-run
  ];
}
