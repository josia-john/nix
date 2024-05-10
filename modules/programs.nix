{ config, pkgs, ... }:

{
    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [
        vim
        git
        light
        nmtui
    ];

    fonts = {
        enableDefaultPackages = true;
    };
}
