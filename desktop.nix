{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ ./x.nix ./sound.nix ./bluetooth.nix ];

  # Use network manager
  networking.networkmanager.enable = true;

  # Modify Steam package:
  #  - add missing libraries for some games
  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      (self: super: {
        steam =
          super.steam.override { extraPkgs = pkgs: with pkgs; [ libpng icu ]; };
      })
    ];
  };

  # It would be better to have steam enabled per user
  programs.steam = { enable = true; };
}
