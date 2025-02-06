{ config, pkgs, lib, ... }:
with lib;
{
    services = {
    syncthing = {
        enable = true;
        group = "users";
        user = "josia";
        dataDir = "/home/josia/Documents";      # Won't be used... Hopefully
        configDir = "/home/josia/Documents/.config/syncthing";
        openDefaultPorts = true;
        overrideDevices = true;     # overrides any devices added or deleted through the WebUI
        overrideFolders = true;     # overrides any folders added or deleted through the WebUI
        settings = {
            devices = {
                "chunky" = { id = "IIRRTSB-AAZSJ7F-QDPMWBU-373OHDL-QT7TL4K-XDJA64Y-7RA2YCN-CF7MGQQ"; };
            };
            folders = {
                "workspace" = {         # Name of folder in Syncthing, also the folder ID
                path = "/home/josia/workspace";    # Which folder to add to Syncthing
                devices = [ "chunky" ];      # Which devices to share the folder with
                };
            };
        };
    };
    };
}