{ config, pkgs, ... }:

{
    hardware.pulseaudio.enable = true;
    hardware.bluetooth.enable = true;
    hardware.pulseaudio.zeroconf.discovery.enable = true;
}
