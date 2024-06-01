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
                    terminal = "foot";
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
                        "${modifier}+Shift+l" = "exec swaylock --clock --indicator --screenshots --effect-pixelate 10 --effect-greyscale";
                        "${modifier}+Shift+s" = "exec swaylock --clock --indicator --screenshots --effect-pixelate 10 --effect-greyscale & systemctl suspend";
                        "${modifier}+Shift+Control+up" = "move workspace to output up";
                        "${modifier}+Shift+Control right" = "move workspace to output right";
                        "${modifier}+Shift+Control+left" = "move workspace to output left";
                        "${modifier}+Shift+Control+down" = "move workspace to output down";
                        "XF86AudioPlay" = "exec playerctl play-pause";
                        "XF86AudioNext" = "exec playerctl next";
                        "XF86AudioPrev" = "exec playerctl previous";
                        "${modifier}+XF86AudioMute" = "exec playerctl play-pause";
                        "${modifier}+XF86AudioRaiseVolume" = "exec playerctl next";
                        "${modifier}+XF86AudioLowerVolume" = "exec playerctl previous";
                    
                        "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
                        "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
                        "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
                        "XF86MonBrightnessUp" = "exec brightnessctl set --exponent=3 10%+";
                        "XF86MonBrightnessDown" = "exec brightnessctl set --exponent=3 10%-";
                        "${modifier}+XF86MonBrightnessUp" = "exec brightnessctl -d tpacpi::kbd_backlight set 1+";
                        "${modifier}+XF86MonBrightnessDown" = "exec brightnessctl -d tpacpi::kbd_backlight set 1-";
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

                    startup = [
                        {
                            command = "sh /usr/share/scripts/autostart.sh";
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
