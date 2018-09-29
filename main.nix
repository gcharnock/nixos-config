# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

let
  nixosUnstable = import <nixos-unstable> {};
  redacted = import /root/redacted.nix;
in
{ config, pkgs, hostName,... }:

{
  imports =
    if hostName == "wayfarer"
      then [ ./hardware-configuration-wayfarer.nix ]
      else [ ./hardware-configuration-symbinix ] ;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.firefox.enableAdobieFlash = true;
  nixpkgs.config.chromium.enablePepperFlash = true;
  nixpkgs.config.chromium.enablePepperPDF = true;

    

  nix = {
    binaryCaches = [
      "https://hie-nix.cachix.org"
    ];
    binaryCachePublicKeys = [
      "hie-nix.cachix.org-1:EjBSHzF6VmDnzqlldGXbi0RM3HdjfTU3yDRi9Pd0jTY="
    ];
  };


  # Use the GRUB 2 boot loader.
  # boot.loader.grub.enable = true;
  # boot.loader.grub.version = 2;

  boot.initrd.luks.devices = [{
    name = "root";
    device = "/dev/sda2";
    preLVM = true;
  }];
  boot.loader.systemd-boot.enable = true;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  # Define on which hard drive you want to install Grub.
  # boot.loader.grub.device = "nodev"; # or "nodev" for efi only

  networking.hostName = hostName; # Define your hostname.
  networking.hosts = {
    "172.17.0.1" = [ "docker" ];
  };
  networking.wireless = {
    enable = true;  # Enables wireless support via wpa_supplicant.
    networks = redacted.networks;
  };

  # Select internationalisation properties.
  i18n = {
  #   consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "uk";
    defaultLocale = "en_GB.UTF-8";
  };

  powerManagement.powerUpCommands = ''
    ${pkgs.hdparm}/sbin/hdparm -Y /dev/sdb
  '';

  # Set your time zone.
  time.timeZone = "Europe/London";

  # editor
  programs.vim.defaultEditor = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
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

  programs.bash.enableCompletion = true;

  virtualisation.docker.enable = true;
  virtualisation.docker.liveRestore = false;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.bash.enableCompletion = true;
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  
  services.syncthing = {
    enable = true;
    user = "gareth";
    group = "users";
    dataDir = "/home/gareth/.syncthing";
  };
  
  

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "gb";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  services.xserver.libinput.enable = true;

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  services.xserver.displayManager.sessionCommands = ''
    xrandr --output VGA-2 --left-of VGA-1
  '';
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.displayManager.gdm.autoLogin.enable = true;
  # services.xserver.displayManager.gdm.autoLogin.user = "gareth";

  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.displayManager.lightdm.autoLogin.enable = true;
  services.xserver.displayManager.lightdm.autoLogin.user = "gareth";

  services.xserver.desktopManager.gnome3.enable = false;
  services.xserver.windowManager.xmonad.enable = true;
  #services.xserver.windowManager.xmonad.enableContribAndExtras = true;
  services.xserver.windowManager.xmonad.extraPackages = hsPkgs: [ hsPkgs.taffybar ];

  services.dockerRegistry = {
    enable = true;
  };


  systemd.user.targets."default.target".wants=[ 
    "compton" "emacs"
  ];

  systemd.user.services."compton" = {
    enable = true;
    description = "";
    path = [ pkgs.compton ];
    wantedBy = [ "default.target" ];
    serviceConfig.Type = "forking";
    serviceConfig.Restart = "always";
    serviceConfig.RestartSpec = 2;
    serviceConfig.ExecStart = "${pkgs.compton}/bin/compton -b";
  };

  systemd.user.services."emacs" = {
    enable = true;
    description = "Emacs text editor";
    serviceConfig.Type = "forking";
    serviceConfig.Restart = "on-failure";
    serviceConfig.RestartSpec = 2;
    serviceConfig.ExecStart = "${pkgs.emacs}/bin/emacs --daemon";
    serviceConfig.ExecStop = "${pkgs.emacs}/bin/emacsclient --eval \"(kill-emacs)\"";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.gareth = {
    createHome = true;
    extraGroups = ["wheel" "docker" "audio"];
    home = "/home/gareth";
    isNormalUser = true;
    uid = 1000;
  };

  security.sudo.wheelNeedsPassword = false;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.03"; # Did you read the comment?
}
