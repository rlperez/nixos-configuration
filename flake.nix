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

    # Pinned to the rev that produced linux-cachyos-bore-lto-x86_64-v3-7.3.1.
    # The newer rev e9e054507cfd56266983751cf03c7d63242f62c1 ships 7.3.4, whose
    # Rust module drivers/block/rnull/rnull_mod.ko fails to produce its
    # per-module BTF (.BTF.1), aborting the module build with:
    #   FAILED: load BTF from drivers/block/rnull/rnull_mod.ko.BTF.1
    # Unpin once 7.3.4 builds clean in this environment. See overlay comment below.
    nix-cachyos-kernel = {
      url = "github:xddxdd/nix-cachyos-kernel/465aeefea2faff3ab6bbf69f6d5c81ac904ceb99";
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

                # gitbutler 0.19.9 added two system dependencies that the nixpkgs
                # recipe does not list:
                #   sqlite     -> linker: "cannot find -lsqlite3"
                #   oniguruma  -> onig_sys build.rs: "Unable to find oniguruma in pkg-config"
                # Remove once nixpkgs ships these in gitbutler's buildInputs.
                gitbutler = prev.gitbutler.overrideAttrs (old: {
                  buildInputs = (old.buildInputs or [ ]) ++ [
                    final.sqlite
                    final.oniguruma
                  ];
                });
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
