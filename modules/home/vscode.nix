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
                rust-lang.rust-analyzer
                github.copilot
                github.copilot-chat
                haskell.haskell
                justusadam.language-haskell
            ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
                {
                    name = "TabOut";
                    publisher = "albert";
                    version = "0.2.2";
                    sha256 = "sha256-s306AHMkUFPaG7ISIr0RscK/k6OVtniIG1CQprBx+cY=";
                }
                ];
            mutableExtensionsDir = false;
        };
    };
}
