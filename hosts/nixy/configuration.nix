{ config, pkgs, ... }:

{
    imports = [
        ./../../hardware-configuration.nix
        ./../../modules
    ];
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    security.polkit.enable = true;
    modules = {
        host = {
            hostname = "nixy";
            username = "josia";
            layout = "dvorak";
        };
    };
}
