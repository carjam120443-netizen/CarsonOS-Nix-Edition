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

  # Install a system-wide Fastfetch config so every user gets the CarsonOS
  # banner by default, while still allowing personal configs to override it.
  environment.etc."xdg/fastfetch/config.jsonc".text = builtins.toJSON {
    logo = {
      type = "raw";
      source = ''
        ('-.     _  .-')    .-')                     .-') _                .-')                 .-') _       ) (`-.
                    ( OO ).-.( \( -O )  ( OO ).                  ( OO ) )              ( OO ).              ( OO ) )       ( OO ).
           .-----.  / . --. / ,------. (_)---\_) .-'),-----. ,--./ ,--,'  .-'),-----. (_)---\_)         ,--./ ,--,' ,-.-')(_/.  \_)-.
          '  .--./  | \-.  \  |   /\`. '/    _ | ( OO'  .-.  '|   \ |  |\ ( OO'  .-.  '/    _ |    .-')  |   \ |  |\ |  |OO)\  `.'  /
          |  |('-..-'-'  |  | |  /  | |\  :` `. /   |  | |  ||    \|  | )/   |  | |  |\  :` `.  _(  OO) |    \|  | )|  |  \ \     /\
         /_) |OO  )\| |_.'  | |  |_.' | '..`''.)\_) |  |\|  ||  .     |/ \_) |  |\|  | '..`''.)(,------.|  .     |/ |  |(_/  \   \ |
         ||  |`-'|  |  .-.  | |  .  '.'.-._)   \  \ |  | |  ||  |\    |    \ |  | |  |.-._)   \ '------'|  |\    | ,|  |_.' .'    \_)
        (_'  '--'\  |  | |  | |  |\  \ \       /   `'  '-'  '|  | \   |     `'  '-'  '\       /         |  | \   |(_|  |   /  .'.  \
           `-----'  `--' `--' `--' '--' `-----'      `-----' `--'  `--'       `-----'  `-----'          `--'  `--'  `--'  '--'   '--'
      '';
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
