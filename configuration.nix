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
    initrd.luks.devices = {
      slow_storage = {
        device = "/dev/disk/by-uuid/9f476a03-d2a3-49eb-84db-fd9639212911";
        keyFile = "/etc/luks-keys/slow_storage.key";
      };

      fast_storage = {
        device = "/dev/disk/by-uuid/ef01f363-ae97-4918-82a2-fa1796bd521a";
        keyFile = "/etc/luks-keys/fast_storage.key";
      };
    };
    kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-bore-lto-x86_64-v3;
  };

  environment.etc = {
    crypttab.text = ''
      slow_storage UUID=9f476a03-d2a3-49eb-84db-fd9639212911 /root/slow_storage.key
      fast_storage UUID=ef01f363-ae97-4918-82a2-fa1796bd521a /root/fast_storage.key
    '';
  };

  fileSystems = {
    "/mnt/slow_storage" = {
      device = "/dev/disk/by-uuid/f0739824-9f6f-4068-acdf-6414331f3511";
      fsType = "ext4";
    };

    "/mnt/fast_storage" = {
      device = "/dev/disk/by-uuid/83d5c600-2d0d-49b0-a0cb-e66cae5a2779";
      fsType = "ext4";
    };
  };

  fileSystems = {
    "/mnt/slow_storage" = {
      device = "/dev/disk/by-uuid/f0739824-9f6f-4068-acdf-6414331f3511";
      fsType = "ext4";
    };

    "/mnt/fast_storage" = {
      device = "/dev/disk/by-uuid/83d5c600-2d0d-49b0-a0cb-e66cae5a2779";
      fsType = "ext4";
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
      inherit pkgs;
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
