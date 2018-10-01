{ config, lib, pkgs, ... }:
let
   hie-nix = import ../hie-nix { };
in
{
  nix = {
    binaryCaches = [
      "https://cache.nixos.org"
      "https://hie-nix.cachix.org"
    ];
    binaryCachePublicKeys = [
      "hie-nix.cachix.org-1:EjBSHzF6VmDnzqlldGXbi0RM3HdjfTU3yDRi9Pd0jTY="
      "hydra.nixos.org-1:CNHJZBh9K4tP3EKF6FkkgeVYsS3ohTl+oS0Qa8bezVs="
    ];
  };

  environment.systemPackages = [
    hie-nix.hies
  ];
}
