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
                "boox" = { id = "7SL52WI-S5WS6FE-72RF5B7-SED4TOT-YBXEOXW-RZRBGVT-4F7BC7F-LWMXQAX"; };
            };
            folders = {
                "workspace/studium" = {         # Name of folder in Syncthing, also the folder ID
                path = "/home/josia/workspace/studium";    # Which folder to add to Syncthing
                devices = [ "boox" ];      # Which devices to share the folder with
                };
                "notes" = {         # Name of folder in Syncthing, also the folder ID
                path = "/home/josia/workspace/notes";    # Which folder to add to Syncthing
                devices = [ "boox" ];      # Which devices to share the folder with
                };
            };
        };
    };
    };
}