{ config, pkgs, lib, ... }:

{
    services.pulseaudio = {
        enable = true;
        zeroconf.discovery.enable = true;
    };
    hardware.bluetooth.enable = true;

    services.pipewire.enable = lib.mkForce false;       # TODO: is this ugly? maybe find the setting which forces me to do this...
}
