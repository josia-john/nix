{ config, pkgs, lib, ... }:
with lib;
{
    options.modules.home.sway = {
        wallpaper = mkOption {
            description = "wallpaper";
            type = types.path;
        };
    };

    config = {
        environment.etc."scripts/autostart.sh" = {
            text = ''
                obsidian &
                code &
                foot &
                chromium &
                thunderbird &
                sleep 5
                sway '[app_id="chromium"]' move container to workspace 1
                sway '[app_id="obsidian"]' move container to workspace 2
                sway '[app_id="code"]' move container to workspace 3
                sway '[app_id="foot"]' move container to workspace 4
                sway '[app_id="thunderbird"]' move container to workspace 10
            '';
        };

        environment.etc."scripts/PASwitchSink.sh" = {
            text = ''
                #! /usr/bin/env sh

                # This script switches between whatever sinks exist.
                # Removing pulseaudio (but not libpulse) means removing pacmd, so this is an attempt at switching the default via pactl instead.

                # Sinks can be specified by name or index. Index changes sometimes when you disconnect and reconnect, restart or whatever, so names are better as they are persistent.
                # Annoyingly the command used to switch audio over to a new sink cannot take a name as its argument, otherwise I'd only need the name here.

                # TODO: Trigger a zenity or dmenu dialog with entr that asks whether to switch monitor and/or sound to hdmi? Could do
                # the same for mounting.

                get_all_sinks() {
                pactl list short sinks | cut -f 2
                }

                get_default_sink() {
                #pw-play --list-targets | grep \* | tail -n 1 | cut -d' ' -f 2 | cut -d : -f 1
                pactl info | grep 'Default Sink' | cut -d':' -f 2-
                }

                DEF_SINK=$(get_default_sink)
                for SINK in $(get_all_sinks) ; do
                [ -z "$FIRST" ] && FIRST=$SINK # Save the first index in case the current default is the last in the list
                # get_default_sink currently returns the index with a leading space
                if [ " $SINK" = "$DEF_SINK" ]; then
                    NEXT=1;
                # Subsequent pass, don't need continue above
                elif [ -n "$NEXT"  ]; then
                    NEW_DEFAULT_SINK=$SINK
                    break
                fi
                done

                # Don't particularly like this method of making it circular, but...
                [ -z "$NEW_DEFAULT_SINK" ] && NEW_DEFAULT_SINK=$FIRST

                # Set default sink for new audio playback
                pactl set-default-sink "$NEW_DEFAULT_SINK"
            '';
        };

        environment.etc."scripts/wallpaper.png" = {
            source = config.modules.home.sway.wallpaper;
        };

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
                        "${modifier}+apostrophe" = "workspace 11";
                        "${modifier}+comma" = "workspace 12";
                        "${modifier}+period" = "workspace 13";
                        "${modifier}+a" = "workspace 14";
                        "${modifier}+o" = "workspace 15";
                        "${modifier}+e" = "workspace 16";

                        "${modifier}+Shift+apostrophe" = "move container to workspace 11";
                        "${modifier}+Shift+comma" = "move container to workspace 12";
                        "${modifier}+Shift+period" = "move container to workspace 13";
                        "${modifier}+Shift+a" = "move container to workspace 14";
                        "${modifier}+Shift+o" = "move container to workspace 15";
                        "${modifier}+Shift+e" = "move container to workspace 16";

                        "${modifier}+p" = "focus parent";
                        "${modifier}+n" = "layout toggle split";
                        "${modifier}+next" = "focus next sibling";
                        "${modifier}+prior" = "focus prev sibling";

                        "${modifier}+Shift+q" = null;
                        "${modifier}+q" = "kill";
                        "${modifier}+d" = null;
                        "${modifier}+space" = "exec rofi -show drun";
                        "${modifier}+Shift+c" = null;
                        "${modifier}+Shift+r" = "reload";
                        "Print" = "exec grim -g \"$(slurp)\"";
                        "${modifier}+Print" = "exec grim -g \"$(slurp)\" - | wl-copy";
                        "${modifier}+Shift+Print" = "exec grim -g \"$(slurp)\" -t png /tmp/qr.png && exec qrscan /tmp/qr.png | wl-copy && exec rm /tmp/qr.png";
                        "${modifier}+Shift+Delete" = "exec swaylock --clock --indicator --screenshots --effect-pixelate 10 --effect-greyscale";
                        "${modifier}+Shift+s" = "exec swaylock --clock --indicator --screenshots --effect-pixelate 10 --effect-greyscale & systemctl suspend";
                        "${modifier}+Shift+Control+up" = "move workspace to output up";
                        "${modifier}+Shift+Control right" = "move workspace to output right";
                        "${modifier}+Shift+Control+left" = "move workspace to output left";
                        "${modifier}+Shift+Control+down" = "move workspace to output down";
                        "XF86AudioPlay" = "exec 'playerctl --player=mpv,%any play-pause'";
                        "XF86AudioNext" = "exec playerctl next";
                        "XF86AudioPrev" = "exec playerctl previous";
                        "${modifier}+XF86AudioMute" = "exec 'playerctl --player=mpv,%any play-pause'";
                        "${modifier}+XF86AudioRaiseVolume" = "exec playerctl next";
                        "${modifier}+XF86AudioLowerVolume" = "exec playerctl previous";
                    
                        "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
                        "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
                        "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
                        "XF86MonBrightnessUp" = "exec brightnessctl set --exponent=3 10%+";
                        "XF86MonBrightnessDown" = "exec brightnessctl set --exponent=3 10%-";
                        "${modifier}+XF86MonBrightnessUp" = "exec brightnessctl -d tpacpi::kbd_backlight set 1+";
                        "${modifier}+XF86MonBrightnessDown" = "exec brightnessctl -d tpacpi::kbd_backlight set 1-";
                        
                        "XF86Favorites" = "exec swaymsg input 'type:keyboard' xkb_switch_layout next";
                    };
                    input = {
                        "type:keyboard" = {
                            "xkb_layout" = "us,us";
                            "xkb_variant" = "dvorak,intl";
                            "xkb_options" = "compose:menu";
                        };
                        "*" = {
                            tap = "enabled";
                            # enabled_sticky = "disabled";
                            drag = "enabled";
                            drag_lock = "disabled";
                        };
                    };
                    output = {
                        DP-1 = {
                            scale = "2";
                            position = "0,0";
                        };
                        HDMI-A-2 = {
                            scale = "1";
                            position = "0,0";
                            # position = "0,-360";
                        };
                        eDP-1 = {
                            scale = "1.25";
                            position = "0,1080";
                            # position = "0,0";
                        };
                        "*" = {
                            bg = "/etc/scripts/wallpaper.png fill";
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
                            command = "sh /etc/scripts/autostart.sh";
                        }
                    ];
                };
                checkConfig = false;
            };

            home.pointerCursor = {
                name = "Adwaita";
                package = pkgs.adwaita-icon-theme;
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
        security.pam.services.swaylock.fprintAuth = true;

        # fix electron apps
        environment.sessionVariables.NIXOS_OZONE_WL = "1";
    };
}
