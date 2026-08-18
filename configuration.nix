{ inputs, pkgs, ... }:
let
  host_name = "nixos";
  primary_username = "fr0bar";
  primary_user_full_name = "Rigoberto L. Perez";
  repo_path = "/home/${primary_username}/Projects/nixos-config";
in
{
  _module.args.primary_username = primary_username;
  _module.args.primary_user_fullname = primary_user_full_name;
  _module.args.repo_path = repo_path;

  imports =
    [
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.home-manager
      ./modules
    ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-bore-lto-x86_64-v3;
  };

  environment.etc = {
    "1password/custom_allowed_browsers" = {
      text = ''
        librewolf
        brave
      '';
      mode = "0755";
    };
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  hardware.keyboard.zsa.enable = true;

  home-manager = {
    extraSpecialArgs = {
      inherit primary_username;
    };

    backupFileExtension = "backup";
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${primary_username} = import ./users/primary-user.nix {
      inherit primary_username;
    };
  };

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  maintenance = {
    repoPath = repo_path;
    hostName = host_name;
  };

  networking = {
    hostName = host_name;
    networkmanager = {
      enable = true;
      wifi = {
        powersave = false;
      };
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "electron-39.8.10"
      "ladybird-0-unstable-2026-06-05"
    ];
  };

  nix = {
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 14d";
      persistent = true;
    };
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
  };

  security.rtkit.enable = true;
  time.timeZone = "America/New_York";

  users.users.${primary_username} = {
    isNormalUser = true;
    description = primary_user_full_name;
    extraGroups = [ "lp" "networkmanager" "podman" "wheel" ];
    shell = pkgs.fish;
  };

  xdg.portal.enable = true;

  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  system = {
    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    stateVersion = "26.05";
    autoUpgrade = {
      dates = "Sun 05:00";
      enable = true;
      flags = [
        "--commit-lock-file"
        "--print-build-logs"
      ];
      flake = "${repo_path}/flake.nix";
      operation = "switch";
      persistent = true;
      randomizedDelaySec = "30min";
    };
  };
}
