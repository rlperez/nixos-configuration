{
  description = "Desktop NixOS System";

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
    nvfetcher.url = "github:berberman/nvfetcher";
  };

  outputs = { self, home-manager, nixpkgs, nix-cachyos-kernel, nvfetcher, ... } @inputs: {
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
    devShells.x86_64-linux.default =
      let
        pkgs = import nixpkgs {
          system = "x86_64-linux";
        };
      in
      pkgs.mkShell {
        packages = [
          nvfetcher.packages.x86_64-linux.default
        ];
      };
  };
}
