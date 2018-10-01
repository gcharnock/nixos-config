{ config, lib, pkgs, ... }:
let
  nixosUnstable = import <nixos-unstable> {};
in
{
  nixpkgs.config.allowUnfree = true;

  i18n = {
    consoleKeyMap = "uk";
    defaultLocale = "en_GB.UTF-8";
  };
  
  time.timeZone = "Europe/London";

  programs.vim.defaultEditor = true;

  services.dockerRegistry = {
    enable = true;
  };

  services.openssh.enable = true;

  programs.bash.enableCompletion = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.gareth = {
    createHome = true;
    extraGroups = ["wheel" "docker" "audio"];
    home = "/home/gareth";
    isNormalUser = true;
    uid = 1000;
  };
  security.sudo.wheelNeedsPassword = false;

  services.syncthing = {
    enable = true;
    user = "gareth";
    group = "users";
    dataDir = "/home/gareth/.syncthing";
  };

  environment.systemPackages = with pkgs; [
    vim
    gitFull
    htop
    chromium
    firefoxWrapper
    nodejs-8_x
    keepassx2
    keepassx2-http
    jetbrains.pycharm-community
    jetbrains.idea-community
    jetbrains.webstorm
    ranger
    dmenu
    rxvt_unicode
    feh
    taffybar
    pgcli
    emacs
    psmisc
    nixosUnstable.stack
    gnumake
    clang
    binutils
    ghc
    haskell.compiler.ghc843
    cabal2nix
    stack2nix
    evince
    nitrogen
    termite
    pavucontrol
    qutebrowser
    docker_compose
    cabal-install
    termite
    tmux
    powertop
    home-manager
    hdparm
    tdesktop
    telegram-cli
    cachix
    wget
    vscode
  ];

  # fonts
  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    noto-fonts-emoji
    font-awesome_5
    siji
    roboto
    roboto-mono
    roboto-slab
    material-icons
  ];
}


