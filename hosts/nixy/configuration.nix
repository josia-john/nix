{ config, pkgs, ... }:

{
    imports = [
        ./../../hardware-configuration.nix
        ./../../modules
    ];
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    modules = {
        host = {
            hostname = "nixy";
            username = "josia";
            layout = "dvorak";
        };
    };
}
