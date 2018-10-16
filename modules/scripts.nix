{ config, lib, pkgs, ... }:
let setup-keyboard = pkgs.writeShellScriptBin "setup-keyboard" ''
  setxkbmap -option "ctrl:nocaps";
  ${pkgs.xorg.xmodmap}/bin/xmodmap -e "keycode 23=Super_L";
  ${pkgs.xorg.xmodmap}/bin/xmodmap -e "keycode any=Tab";
  ${pkgs.xorg.xmodmap}/bin/xmodmap -e "keycode 36=Hyper_R";
  ${pkgs.xorg.xmodmap}/bin/xmodmap -e "keycode any=Return";
  ${pkgs.xorg.xmodmap}/bin/xmodmap -e "add mod3 = Hyper_R";
  ${pkgs.systemd}/bin/systemctl --user restart xcape;
'';
in
{
  environment.systemPackages = with pkgs; [
    setup-keyboard
  ];
}


