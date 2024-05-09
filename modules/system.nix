{
    config,
    lib,
    ...
}:

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
        networking.hostName = options.modules.system.hostname;

        users.users.${options.modules.system.username} = {
            isNormalUser = true;
            extraGroups = [ "wheel" ];
        };

    };
}
