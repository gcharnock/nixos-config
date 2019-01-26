{ config, lib, pkgs, ... }:
let
in
{
  nixpkgs.config.allowUnfree = true;

  i18n = {
    #consoleKeyMap = "uk";
    defaultLocale = "en_GB.UTF-8";
    consoleUseXkbConfig = true;
  };
 
  # Don't make everything unresponseive 
  nix.daemonIONiceLevel = 5;
  nix.daemonNiceLevel = 10;

  nix.gc.automatic = true;
  nix.gc.dates = "13:00";
  nix.gc.options = "--delete-older-than=20d";

  nix.optimise.automatic = true;
  nix.optimise.dates = ["14:00"];
  
  time.timeZone = "Europe/London";

  programs.vim.defaultEditor = true;
  boot.cleanTmpDir = true;

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
    htop
    nodejs-8_x
    ranger
    dmenu
    pgcli
    emacs
    psmisc
    gnumake
    binutils
    tmux
    powertop
    home-manager
    hdparm
    cachix
    wget
    unzip
    python3
    openssl
    gcc
    pypi2nix
    libxml2
    imagemagick
    postgresql100  # For command line tools like pg_dump
    ntfs3g
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


