{ config, pkgs, ... }:

{
    programs.zsh = {
        enable = true;
        ohMyZsh = {
            enable = true;
            theme = "robbyrussell";
        };
        histSize = 1000000;
    };
    system.userActivationScripts.zshrc = "touch .zshrc";
}
