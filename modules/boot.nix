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
        driSupport32Bit = true;                             # Build for ARM
        extraPackages = with pkgs; [
            intel-compute-runtime
        ];
    };

    boot.binfmt.emulatedSystems = [ "aarch64-linux" ];      # Build for ARM
}
