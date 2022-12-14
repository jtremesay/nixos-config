{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ ./home/jtremesay/desktop.nix ];

  hardware = {
    bluetooth.enable = true;
    pulseaudio = {
      enable = true;
      support32Bit = true;
    };
  };
  nixpkgs = {
    config = {
      allowUnfree = true;
      pulseaudio = true;
    };
    overlays = [
      (self: super: {
        steam =
          super.steam.override { extraPkgs = pkgs: with pkgs; [ libpng icu ]; };
      })
    ];
  };
  # It would be better to have steam enabled per user
  programs.steam.enable = true;
  services = {
    blueman.enable = true;
    xserver = {
      enable = true;

      # Configure X keyboard
      layout = "fr";
      xkbVariant = "bepo";

      # Enable touchpad support (enabled default in most desktopManager).
      libinput.enable = true;

      # Display manager
      displayManager = {
        autoLogin = {
          enable = true;
          user = config.users.users.jtremesay.name;
        };
        sddm.enable = true;
        session = [{
          manage = "desktop";
          name = "XSession";
          start = "exec $HOME/.xsession";
        }];
      };
    };
  };
}
