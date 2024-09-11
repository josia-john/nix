{ config, pkgs, lib, ... }:

{
    hardware.pulseaudio.enable = true;
    hardware.bluetooth.enable = true;
    hardware.pulseaudio.zeroconf.discovery.enable = true;

    services.pipewire.enable = lib.mkForce false;       # TODO: is this ugly? maybe find the setting which forces me to do this...
}
