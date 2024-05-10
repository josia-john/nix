{ config, pkgs, ... }:

{
    home-manager.users.${config.modules.host.username} = {
        home.username = "${config.modules.host.username}";
        home.homeDirectory = "/home/${config.modules.host.username}";
        
        home.packages = with pkgs; [
            firefox
            alacritty
            htop
            grim
            slurp
            wl-clipboard
            swaybg
        ]

        programs.home-manager.enable = true;

        home.stateVersion = "23.11";
    };
}
