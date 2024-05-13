{ config, pkgs, ... }:

{
    programs.zsh = {
        enable = true;
        ohMyZsh = {
            enable = true;
            theme = "robbyrussell";
        };
    };
    system.userActivationScripts.zshrc = "touch .zshrc";
}
