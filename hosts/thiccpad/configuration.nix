{ config, pkgs, lib, ... }:
with lib;
{
    imports = [
        ./hardware-configuration.nix
        ./../../modules
    ];

    config = {
        modules = {
            host = {
                hostname = "thiccpad";
                username = "josia";
            };
            home.sway = {
                wallpaper = ./../../images/X200.png;
            };
        };

        # overwrite boot options:

        boot.loader = lib.mkForce {
            grub = {
                enable=true;
                device="/dev/sda";
                efiSupport=false;
                useOSProber=true;
            };
        };
        
        # overwrite startup:

        
        environment.etc."scripts/autostart.sh" = lib.mkForce {
            text = ''
                
            '';
        };
    };
    
}
