{ config, pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ./../../modules
    ];

    modules = {
        host = {
            hostname = "nixy";
            username = "josia";
        };
        home.sway = {
            wallpaper = ./../../images/T480.png;
        };
    };

    swapDevices = [{
        device = "/swapfile";
        size = 16 * 1024; # 16GB
    }];
}
