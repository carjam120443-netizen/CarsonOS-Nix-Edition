{ config, pkgs, lib, ... }:

{
  networking.hostName = "carsonos";

  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [
    firefox
    git
    fastfetch
    vim
    wget
    curl
    pciutils
    usbutils
  ];

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  hardware.enableRedistributableFirmware = true;

  # Change only when intentionally adopting a newer NixOS release.
  system.stateVersion = "26.05";
}
