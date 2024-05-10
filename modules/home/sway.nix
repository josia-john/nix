{ config, pkgs, ... }:

{
    home-manager.users.${config.modules.host.username} = {
        wayland.windowManager.sway.enable = true;
    };
}
