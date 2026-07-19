{
  description = "Desktop NixOS System";

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
  };

  outputs = { self, home-manager, nixpkgs, nix-cachyos-kernel, ... } @inputs: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
        };
        system = "x86_64-linux";
        modules = [
          ({ pkgs, ... }: {
            nixpkgs.overlays = [
              (import ./overlays/default.nix)
              (final: prev: {
                inherit (prev.lixPackageSets.stable)
                  nixpkgs-review
                  nix-eval-jobs
                  nix-fast-build
                  colmena;
              })
              nix-cachyos-kernel.overlays.pinned
            ];

            nix.package = pkgs.lixPackageSets.stable.lix;
          })
          home-manager.nixosModules.home-manager
          ./configuration.nix
        ];
      };
    };
  };
}
