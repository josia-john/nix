{ config, pkgs, ... }:

{
    environment.systemPackages = [
        pkgs.thunderbird
        pkgs.emacs
    ];
}