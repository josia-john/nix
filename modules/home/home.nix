{ config, pkgs, ... }:

{
    home-manager.users.${config.modules.host.username} = {
        home.username = "${config.modules.host.username}";
        home.homeDirectory = "/home/${config.modules.host.username}";
        
        home.packages = with pkgs; [
            firefox
            foot
            htop
            grim
            slurp
            wl-clipboard
            swaybg
            obsidian
            rofi-wayland
            swayimg
            texliveFull
            thunderbird
            pavucontrol
            pandoc
            playerctl
            libreoffice
            gthumb
            mupdf
            yt-dlp
            vlc
            mpv
            qbittorrent
            davinci-resolve
            arduino
        ];

        services =  {
            mako = {
                enable = true;
                defaultTimeout = 4000;
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
