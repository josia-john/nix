{ config, pkgs, ... }:

{
    config = {
        home-manager.users.josia.wayland.windowManager.sway.enable = true;
    };
}
