{ config, pkgs, ... }:

{
    home-manager.users.${config.modules.host.username} = {
        wayland.windowManager.sway = {
            enable = true;
            config = {
                modifier = "Mod4";
                input = {
                    "type:keyboard" = {
                        "xkb_layout" = "dvorak";
                    };
                };
            };
        };
    };
}
