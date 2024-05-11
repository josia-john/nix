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
                    input = {
                        "type:keyboard" = {
                            "xkb_layout" = "us";
                            "xkb_variant" = "dvorak";
                            "xkb_options" = "compose:menu";
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
        };

        # fix electron apps
        environment.sessionVariables.NIXOS_OZONE_WL = "1";
    };
}
