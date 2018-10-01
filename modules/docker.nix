{ config, lib, pkgs, ... }:
{
  virtualisation.docker.enable = true;
  virtualisation.docker.liveRestore = false;

  networking.hosts = {
    "172.17.0.1" = [ "docker" ];
  };
}