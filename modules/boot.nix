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

    hardware.graphics = {
        enable = true;
        enable32Bit = true;                             # Build for ARM
        extraPackages = with pkgs; [
            intel-compute-runtime
        ];
    };

    swapDevices = [{
        device = "/swapfile";
        size = 16 * 1024; # 16GB
    }];

    boot.binfmt.emulatedSystems = [ "aarch64-linux" ];      # Build for ARM
}
