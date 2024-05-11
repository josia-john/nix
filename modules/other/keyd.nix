{ config, pkgs, ... }:

{
    services.keyd = {
        enable = true;

        keyboards = {
            default = {
                ids = [ "*" ];
                settings = {
                    main = {
                        capslock = "esc";
                        rightalt = "layer(umlauts)";
                    };
                    umlauts = {
                        a = "macro(compose a Q)";
                        s = "macro(compose s Q)";
                        d = "macro(compose d Q)";
                        f = "macro(compose f Q)";
                        g = "macro(compose g Q)";
                    };
                };
            };
        };
    };
}
