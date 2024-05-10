{
    config,
    lib,
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

        layout = mkOption {
            description = "keyboard layout for this system";
            default = "us";
            type = types.str;
        };
    };

    config = {
        networking = {
            hostName = config.modules.host.hostname;
            networkmanager.enable = true;
        };

        users.users.${config.modules.host.username} = {
            isNormalUser = true;
            extraGroups = [ "wheel" ];
            initialPassword = config.modules.host.initialPassword;
        };

        console.keyMap = config.modules.host.layout;

    };
}
