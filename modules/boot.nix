{ config, pkgs, ... }:

{
    boot.loader = {
        efi = {
            canTouchEfiVariables = true;
        };
        grub = {
            enable = true;
            efiSupport = true;
            device = "nodev";
        };
    };

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    security.polkit.enable = true;

    hardware.opengl = {
        enable = true;
    };
}
