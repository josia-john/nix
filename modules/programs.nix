{ config, pkgs, ... }:

{
    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [
        vim
        git
        light
        neofetch
    ];

    fonts = {
        enableDefaultPackages = true;
    };
}
