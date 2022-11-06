{ config, lib, pkgs, modulesPath, ... }:

{
  # Nix store optim
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
  };

  # Nix experimental features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
