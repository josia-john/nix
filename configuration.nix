{ config, pkgs, ... }:

{
    imports = [
        /home/josia/hardware-configuration.nix
        ./modules
    ];
    boot.loader.systemd-boot.enable=true;

    console.keyMap = "dvorak";

    modules = {
        system = {
            hostname = "nixy";
            username = "josia";
        };
    };
}
