{ config, pkgs, ... }:

{
    imports = [
        /home/josia/hardware-configuration.nix
        ./modules
    ];

    modules = {
        host = {
            hostname = "nixy";
            username = "josia";
            layout = "dvorak";
        };
    };
}
