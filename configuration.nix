{ config, pkgs, ... }:

{
    imports = [
        /etc/nixos/hardware-configuration.nix
        ./modules
    ];

    console.keyMap = "dvorak";

    modules = {
        system = {
            hostname = "nixy";
            username = "josia";
        };
    }
}