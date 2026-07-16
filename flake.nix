{
  description = "Desktop NixOS System";

  inputs = {
    # Tracking the unstable channel for cutting-edge packages
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
  };

  outputs = { self, nixpkgs, nix-cachyos-kernel, ... } @inputs: {
    nixosConfigurations = {
      # Replace "nixos" with your actual hostname if you changed it
      nixos = nixpkgs.lib.nixosSystem {
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
          ./configuration.nix
        ];
      };
    };
  };
}
