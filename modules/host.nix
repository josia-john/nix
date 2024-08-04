{
    config,
    lib,
    pkgs,
    ...
}:
with lib;
{
    options.modules.host = {
        hostname = mkOption {
            description = "hostname for this system";
            type = types.str;
        };

        username = mkOption {
            description = "username for this system";
            type = types.str;
        };

        initialPassword = mkOption {
            description = "initial password for this system";
            default = "123456";
            type = types.str;
        };
    };

    config = {
        networking = {
            hostName = config.modules.host.hostname;
            networkmanager.enable = true;

            extraHosts =
                ''
                    94.177.8.216 myserver
                '';

            firewall = {
                allowedTCPPortRanges = [
                    { from = 3000; to = 3003; }
                    { from = 8000; to = 8003; }
                    { from = 8080; to = 8083; }
                    { from = 5500; to = 5503; }
                ];
            };
        };

        services.avahi = {
            enable = true;
            nssmdns = true;
            openFirewall = true;
            publish = {
                enable = true;
                userServices = true;
                addresses = true;
            };
        };

        users.users.${config.modules.host.username} = {
            shell = pkgs.zsh;
            isNormalUser = true;
            extraGroups = [ "wheel" ];
            initialPassword = config.modules.host.initialPassword;
        };

        console.keyMap = "dvorak";

        services.automatic-timezoned.enable = true;
        # weird networkmanager fails
        systemd.services.NetworkManager-wait-online.enable = false;
    };
}
