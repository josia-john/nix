{ config, pkgs, ... }:

{
    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [
        vim
        git
        brightnessctl
        neofetch
        zip
        unzip
        wget
        gcc
        w3m
    ];

    fonts = {
        enableDefaultPackages = true;
        fontDir.enable = true;
        packages = with pkgs; [
            nerdfonts
        ];
    };

    services.printing.enable = true;
    services.printing.drivers = [ pkgs.hplip ];
}
