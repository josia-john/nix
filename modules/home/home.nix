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
            obsidian
            rofi-wayland
            swayimg
        ];

        services =  {
            mako = {
                enable = true;
                defaultTimeout = 2000;
            };
        };

        programs.git = {
            enable = true;
            userName  = "Josia John";
            userEmail = "josia.j.john@gmail.com";
        };

        programs.home-manager.enable = true;
        nixpkgs.config.allowUnfree = true;

        home.stateVersion = "23.11";
    };
}
