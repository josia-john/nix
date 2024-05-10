{ config, pkgs, ... }:

{
    imports = [
        ./../../hardware-configuration.nix
        ./../../modules
    ];

    modules = {
        host = {
            hostname = "nixy";
            username = "josia";
        };
        home = {
            sway.wallpaper = "/usr/share/backgrounds/t480.png";
        };
    };
}
