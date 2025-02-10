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
            uxplay
            wireshark
            patchelf
            gnucash
            dconf       # Required by gnucash to save state!
            bitwarden
            qrscan
            nmap
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

        programs.rofi = {
            enable = true;
            package = pkgs.rofi-wayland;
            font = "MesloLGS Nerd Font 12";
            theme = "material";
        };

        programs.home-manager.enable = true;

        programs.sioyek.enable = true;

        nixpkgs.config.allowUnfree = true;

        home.stateVersion = "23.11";
    };
}
