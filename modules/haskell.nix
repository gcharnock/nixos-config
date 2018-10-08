{ config, lib, pkgs, ... }:
let
  nixosUnstable = import <nixos-unstable> {};
  defaultHSEnv = pkgs.haskellPackages.ghcWithHoogle
    (hsPkgs: with hsPkgs; [
      base
      bytestring
      cryptonite
      directory
      filepath
      hashable
      hashtables
      hinotify
      interpolate
      lens
      memory
      mtl
      rawfilepath
      text
      transformers
      unliftio
      unliftio-core
      utf8-string
  ]);
in
{
  environment.systemPackages = with pkgs; [
    defaultHSEnv
    cabal2nix
    stack2nix
    cabal-install
    nixosUnstable.stack
    haskellPackages.brittany
    haskellPackages.hoogle
    haskellPackages.bhoogle
  ];
}

