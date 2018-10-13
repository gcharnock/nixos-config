{ config, lib, pkgs, ... }:
{

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  services.xserver = {
    enable = true;
    layout = "gb";

    # Enable touchpad support.
    libinput.enable = true;

    displayManager.sessionCommands = ''
    xrandr --output VGA-2 --left-of VGA-1
    '';

    desktopManager.xterm.enable = true;

    displayManager.lightdm.enable = true;
    displayManager.lightdm.autoLogin.enable = true;
    displayManager.lightdm.autoLogin.user = "gareth";

    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = hsPkgs: [ hsPkgs.taffybar ];
    };
    windowManager.default = "xmonad";

    xkbOptions = "ctrl:nocaps";
  };


  programs.slock.enable = true;

  systemd.user.targets."default.target".wants=[ 
    "compton"
  ];

  nixpkgs.config.firefox.enableAdobieFlash = true;
  nixpkgs.config.chromium.enablePepperFlash = true;
  nixpkgs.config.chromium.enablePepperPDF = true;

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

  systemd.user.services."keynav" = {
    enable = true;
    description = "Ditch the mouse";
    path = [ pkgs.keynav ];
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      Restart = "always";
      RestartSpec = 2;
      ExecStart = "${pkgs.keynav}/bin/keynav";
    };
  };

  # Not sure if this is the best way to do this...
  systemd.user.services."xmonad-pipes" = {
    enable= true;
    description = "FIFO for XMonad window name";
    wantedBy = [ "default.target" ];
    script = ''
      WINDOW_NAME=''${HOME}/var/xmonad-window-name.fifo;
      WORKSPACE_NAME=''${HOME}/var/xmonad-workspace.fifo;

      if [ ! -e ''${WINDOW_NAME} ]; then
	      ${pkgs.coreutils}/bin/mkfifo ''${WINDOW_NAME};
      fi

      if [ ! -e ''${WORKSPACE_NAME} ]; then
	      ${pkgs.coreutils}/bin/mkfifo ''${WORKSPACE_NAME};
      fi
    '';
    serviceConfig = {
       Restart = "no";
    };
  };

  environment.systemPackages = with pkgs; [
    gitFull
    chromium
    firefoxWrapper
    keepassx2
    keepassx2-http
    jetbrains.pycharm-community
    jetbrains.idea-community
    jetbrains.webstorm
    dmenu
    rxvt_unicode
    feh
    evince
    nitrogen
    termite
    pavucontrol
    qutebrowser
    termite
    powertop
    tdesktop
    taffybar
    vscode
    spotify
    twmn
    keynav
  ];
}
