{
  description = "Desktop NixOS System";

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-ld = {
      url = "github:Mic92/nix-ld";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-cachyos-kernel = {
      url = "github:xddxdd/nix-cachyos-kernel";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvfetcher.url = "github:berberman/nvfetcher";
  };

  outputs = { self, home-manager, nixpkgs, nix-cachyos-kernel, nix-ld, nvfetcher, ... } @inputs: {
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
          nix-ld.nixosModules.nix-ld
          home-manager.nixosModules.home-manager
          ./configuration.nix
        ];
      };
    };
    devShells.x86_64-linux.default =
      let
        system = "x86_64-linux";
        pkgs = import nixpkgs {
          system = system;
        };
      in
      pkgs.mkShell {
        packages = [
          nvfetcher.packages.${system}.default
        ];
      };
  };
}
