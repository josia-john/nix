{
    description = "My NixOS config";
    
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        home-manager.url = "github:nix-community/home-manager";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
    };
    
    outputs = inputs@{ nixpkgs, home-manager, ... }: {
        nixosConfigurations = {
            nixy = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                modules = [
                    ./hosts/nixy/configuration.nix
                    home-manager.nixosModules.home-manager
                ];
            };
            thiccpad = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                modules = [
                    ./hosts/thiccpad/configuration.nix
                    home-manager.nixosModules.home-manager
                ];
            };
            chunky = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                modules = [
                    ./hosts/chunky/configuration.nix
                    home-manager.nixosModules.home-manager
                ];
        };
    };
}
