{ config, pkgs, ... }:

{
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
                        scale = "1.5";
                        position = "0,1080";
                    };
                };
            };
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
}
