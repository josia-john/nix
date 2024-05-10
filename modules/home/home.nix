{ config, pkgs, ... }:

{
    home-manager.users.${config.modules.host.username} = {
        home.stateVersion = "23.11";
    };
}
