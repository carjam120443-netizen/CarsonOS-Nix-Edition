{ config, pkgs, lib, ... }:

{
  networking.hostName = "carsonos";

  # Use the stable Lix implementation instead of upstream CppNix.
  nix.package = pkgs.lixPackageSets.stable.lix;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

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

  # Install a system-wide Fastfetch config so every user gets the CarsonOS
  # banner by default. Keep the ASCII art in a separate file: Nix indented
  # strings use two apostrophes as a terminator, which the art itself contains.
  environment.etc."xdg/fastfetch/config.jsonc".text = builtins.toJSON {
    logo = {
      type = "raw";
      source = builtins.readFile ./assets/carsonos-ascii.txt;
    };
  };

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
