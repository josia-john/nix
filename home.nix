{ config, pkgs, ... }:

{
  home.username = "josia";
  home.homeDirectory = "/home/josia";

  home.packages = with pkgs; [
    firefox
    htop
    alacritty
    waybar
    grim
    slurp
    wl-clipboard
    swaybg
  ];

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;

  wayland.windowManager.sway = {
    enable = true;
    config = {
      modifier = "Mod4";
      terminal = "alacritty";
      bars = [{
        # command = "waybar";
      }];
      fonts.names = [ "monospace" ];
    };
    extraConfig = ''
      input "type:keyboard" {
        xkb_layout "us"
        xkb_variant "dvorak"
        xkb_options compose:menu
      }
      output "*" bg /usr/share/backgrounds/t480.png fill
    '';
    checkConfig = false;
  };
}  
