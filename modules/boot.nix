{ config, pkgs, ... }:

{
    boot.loader.grub.enable=true;
    boot.loader.grub.device="/dev/sda";
    boot.loader.grub.useOSProber=true;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    security.polkit.enable = true;

    hardware.opengl = {
        enable = true;
    };
}
