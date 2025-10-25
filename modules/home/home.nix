{ config, pkgs, ... }:

{
    home-manager.users.${config.modules.host.username} = {
        home.username = "${config.modules.host.username}";
        home.homeDirectory = "/home/${config.modules.host.username}";

        home.packages = with pkgs; [
            chromium
            firefox
            foot
            alacritty
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
            qbittorrent
            davinci-resolve
            uxplay
            wireshark
            patchelf
            gnucash
            dconf       # Required by gnucash to save state!
            bitwarden
            qrscan
            nmap
            ghc         # haskell
            haskellPackages.haskell-language-server
            wf-recorder
            openconnect
            kicad
            rpi-imager
            wayvnc
            jq
            pulseaudio
            kstars
            phd2
            stellarium
            wdisplays
            tree
            element-desktop
        ];

        services =  {
            mako = {
                enable = true;
                settings = {
                    layer = "overlay";
                    default-timeout = 4000;
                    ignore-timeout = true;
                };
                extraConfig = ''
                    # Blocked mode: hide all notifications
                    [mode=blocked]
                    invisible=1
                    '';
            };
        };

        programs.git = {
            enable = true;
            userName  = "Josia John";
            userEmail = "josia.j.john@gmail.com";
        };

        programs.mpv = {
            enable = true;
            scripts = [ pkgs.mpvScripts.mpris pkgs.mpvScripts.mpv-cheatsheet ];
            # scripts = [ pkgs.mpvScripts.mpris pkgs.mpvScripts.mpv-cheatsheet pkgs.mpvScripts.autosub ];
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
