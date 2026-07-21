{ inputs, pkgs, ... }:
{
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

  nixpkgs.config.permittedInsecurePackages = [
    "electron-39.8.10"
  ];

  networking = {
    hostName = "nixos";
    networkmanager = {
      enable = true;
      wifi = {
        powersave = false;
      };
    };
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  hardware.keyboard.zsa.enable = true;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    users.fr0bar = import ./users/fr0bar.nix;
  };

  time.timeZone = "America/New_York";

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

  security.rtkit.enable = true;
  users.users."fr0bar" = {
    isNormalUser = true;
    description = "Rigoberto L. Perez";
    extraGroups = [ "networkmanager" "wheel" "podman" ];
    shell = pkgs.fish;
  };

  programs.nix-ld.enable = true;

  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [ "nix-command" "flakes" ];
  };

  xdg.portal.enable = true;

  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05";
}
