{ config, lib, pkgs, ... }:
let
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
    git
    htop
    nodejs-8_x
    ranger
    dmenu
    pgcli
    emacs
    psmisc
    gnumake
    clang
    binutils
    docker_compose
    tmux
    powertop
    home-manager
    hdparm
    cachix
    wget
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


