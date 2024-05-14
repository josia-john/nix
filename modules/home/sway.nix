{ config, pkgs, lib, ... }:
with lib;
{
    options.modules.home.sway = {
        wallpaper = mkOption {
            description = "wallpaper for sway; leave empty for no wallpaper";
            type = types.str;
            default = "";
        };
    };

    config = {
        home-manager.users.${config.modules.host.username} = {
            wayland.windowManager.sway = {
                enable = true;
                config = {
                    modifier = "Mod4";
                    menu = "rofi -show drun";
                    terminal = "alacritty";
                    keybindings =
                        let
                        # modifier = config.home-manager.users.${config.modules.host.username}.wayland.windowManager.sway.config.modifier;
                        modifier = "Mod4";
                        in lib.mkOptionDefault {
                        "${modifier}+Shift+q" = null;
                        "${modifier}+q" = "kill";
                        "${modifier}+d" = null;
                        "${modifier}+space" = "exec rofi -show drun";
                        "${modifier}+Shift+c" = null;
                        "${modifier}+Shift+r" = "reload";
                        "Print" = "exec grim -g \"$(slurp)\"";
                        "${modifier}+l" = "exec swaylock --clock --indicator --screenshots --effect-pixelate 10 --effect-greyscale";
                    };
                    input = {
                        "type:keyboard" = {
                            "xkb_layout" = "us";
                            "xkb_variant" = "dvorak";
                            "xkb_options" = "compose:menu";
                        };
                        "*" = {
                            tap = "enabled";
                        };
                    };
                    output = {
                        DP-1 = {
                            scale = "2";
                            position = "0,0";
                        };
                        eDP-1 = {
                            scale = "1.25";
                            position = "0,1080";
                        };
                        "*" = {
                            bg = if (config.modules.home.sway.wallpaper != "") then "${config.modules.home.sway.wallpaper} fill" else "#000000 solid_color";
                        };
                    };

                    bars = [
                        {
                            position = "top";
                            command = "waybar";
                        }
                    ];
                };
                checkConfig = false;
            };

            home.pointerCursor = {
                name = "Adwaita";
                package = pkgs.gnome.adwaita-icon-theme;
                size = 24;
                x11 = {
                    enable = true;
                    defaultCursor = "Adwaita";
                };
            };

            # lockscreen
            programs.swaylock = {
                enable = true;
                package = pkgs.swaylock-effects;
            };
        };

        # fix swaylock
        security.pam.services.swaylock = {};

        # fix electron apps
        environment.sessionVariables.NIXOS_OZONE_WL = "1";
    };
}
