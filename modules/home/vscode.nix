{ config, pkgs, ... }:

{
    home-manager.users.${config.modules.host.username} = {
        programs.vscode = {
            enable = true;
            extensions = with pkgs.vscode-extensions; [
                bbenoist.nix
                ms-vscode.cpptools
                james-yu.latex-workshop
                mathiasfrohlich.kotlin
                ritwickdey.liveserver
                ms-python.python
                ocamllabs.ocaml-platform
                ms-toolsai.jupyter
            ];
            mutableExtensionsDir = false;
        };
    };
}
