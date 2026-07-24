{ ... }: {
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };
  services.printing = {
    enable = true;
  };
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    nssmdns6 = false;
    openFirewall = true;
  };
  services.pulseaudio.enable = false;
  services.xserver.enable = true;
  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
    };
  };
  services.desktopManager.plasma6.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
}
