{ config, pkgs, ... }:

{
    boot.loader.systemd-boot.enable=true;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    security.polkit.enable = true;
}
