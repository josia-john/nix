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
    };
}
