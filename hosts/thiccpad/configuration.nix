{ config, pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ./../../modules
    ];

    modules = {
        host = {
            hostname = "thiccpad";
            username = "josia";
        };
        home.sway = {
            wallpaper = ./../../images/X200.png;
        };
    };
}
