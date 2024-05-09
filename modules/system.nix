{
    config,
    lib,
    ...
}:
with lib;
{
    options.modules.system = {
        hostname = mkOption {
            description = "hostname for this system";
            type = types.str;
        };

        username = mkOption {
            description = "username for this system";
            type = types.str;
        };
    };

    config = {
        networking.hostName = config.modules.system.hostname;

        users.users.${config.modules.system.username} = {
            isNormalUser = true;
            extraGroups = [ "wheel" ];
        };

    };
}
