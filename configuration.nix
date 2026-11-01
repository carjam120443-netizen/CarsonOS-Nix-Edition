{ config, pkgs, lib, ... }:

{
  networking.hostName = "carsonos";

  # Use the stable Lix implementation instead of upstream CppNix.
  nix.package = pkgs.lixPackageSets.stable.lix;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Provide `pkg` as a convenient alias while keeping the original `nix` command.
  environment.shellAliases = {
    pkg = "nix";
  };

  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Optional i3 tiling window manager. Plasma remains available in SDDM;
  # choose the i3 session from the login screen when desired.
  services.xserver.windowManager.i3 = {
    enable = true;
    extraPackages = with pkgs; [
      dmenu
      i3status
      i3lock
    ];
  };

  networking.networkmanager.enable = true;

  # Use the feature-complete Git variant by default.
  # Switch to pkgs.git or pkgs.gitMinimal here if a smaller install is preferred.
  programs.git = {
    enable = true;
    package = pkgs.gitFull;
  };

  # Enable zsh so the Deer file-navigation function can be used.
  programs.zsh.enable = true;

  # Provide Debian/Ubuntu userspace through containers rather than running
  # apt/dpkg against the NixOS host filesystem.
  virtualisation.podman.enable = true;

  environment.systemPackages = with pkgs; [
    firefox
    fastfetch
    fetchutils
    cpufetch
    ufetch
    nerdfetch
    pridefetch
    ramfetch
    honeyfetch
    vim
    wget
    curl
    pciutils
    usbutils
    textadept
    gnugrep
    distrobox
    podman
    deer
    cmatrix
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
