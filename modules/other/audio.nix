{ config, pkgs, lib, ... }:

{
#     services.pulseaudio = {
#         enable = true;
#         # zeroconf.discovery.enable = true;
#         extraConfig = "
# load-module module-null-sink sink_name=rtp sink_properties=\"device.description='RTP'\"
# load-module module-rtp-send source=rtp.monitor destination_ip=10.8.100.146";
#     };
#     hardware.bluetooth.enable = true;

#     services.pipewire.enable = lib.mkForce false;       # TODO: is this ugly? maybe find the setting which forces me to do this...
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        # opens UDP ports 6001-6002
        raopOpenFirewall = true;

        extraConfig.pipewire = {
            "10-airplay" = {
            "context.modules" = [
                {
                name = "libpipewire-module-raop-discover";

                # increase the buffer size if you get dropouts/glitches
                args = {
                  "raop.latency.ms" = 1000;
                };
                }
                {
                    name = "libpipewire-module-roc-sink";
                    args = {
                        "fec.code" = "disable"; # Replace with your desired multicast or unicast IP
                        "remote.ip" = "10.8.100.165";
                        "remote.source.port" = 10001;
                        "remote.repair.port" = 10002;
                        "remote.control.port" = 10003;
                        "sink.name" = "roc-sink";
                        "sink.props" = {
                            "node.name" = "roc-sink";
                            "node.description" = "ROC Sink";
                            "media.class" = "Audio/Sink";
                        };
                    };
                    # Use `roc-recv -s rtp://0.0.0.0 (--sess-latency=100ms)` on remote machine
                }
            ];
            };
        };
        wireplumber.enable = true;
    };
    hardware.bluetooth.enable = true;
    xdg.portal = {
        config.common.default = "*";
        enable = true;
        wlr.enable = true;
        extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
    };
}
