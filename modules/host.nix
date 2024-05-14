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
