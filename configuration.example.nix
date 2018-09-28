{ config, pkgs, ... }:
import ./main.nix {
 inherit config;
 inherit pkgs;
 hostName="wayfarer";
}
