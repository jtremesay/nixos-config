{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./nix.nix
    ./pkgs.nix
    ./services.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
  console = {
    font = "Lat2-Terminus16";
    keyMap = "fr-bepo";
  };
  i18n.defaultLocale = "en_US.UTF-8";
  networking = {
    domain = "slaanesh.org";
    nameservers = [ 
      "9.9.9.9" 
      "149.112.122.122" 
      "[2620:fe::fe]" 
      "[2620:fe::9]" 
    ];
    search = [ config.networking.domain ];
  };
  security.sudo.wheelNeedsPassword = false;
  services = {
    resolved.enable = true;
  };
  system = {
    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    stateVersion = "22.05"; # Did you read the comment?

    # Copy the NixOS configuration file and link it from the resulting system
    # (/run/current-system/configuration.nix). This is useful in case you
    # accidentally delete configuration.nix.
    copySystemConfiguration = true;
  };
  time.timeZone = "Europe/Paris";
}
