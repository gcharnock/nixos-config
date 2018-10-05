{ config, lib, pkgs, ... }:
let
  nixosUnstable = import <nixos-unstable> {};
in
{
  environment.systemPackages = with pkgs; [
    ghc
    haskell.compiler.ghc843
    cabal2nix
    stack2nix
    cabal-install
    nixosUnstable.stack
    haskellPackages.brittany
  ];
}

