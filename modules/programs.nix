{ config, pkgs, ... }:

{
    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [
        pwgen
        vim
        git
        brightnessctl
        neofetch
        zip
        unzip
        wget
        gcc
        gdb
        gnumake
        w3m
        python3
        man-pages
        rustup
        qdirstat
    ];

    fonts = {
        enableDefaultPackages = true;
        fontDir.enable = true;
        packages = with pkgs; [
            nerd-fonts.meslo-lg
        ];
    };

    services.printing.enable = true;
    services.printing.drivers = [ pkgs.hplip ];

    services.davfs2 = {
        enable = true;
        settings = {
            globalSection = {
                use_locks = false;
            };
        };
    };
}
