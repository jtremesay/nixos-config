{ config, lib, pkgs, modulesPath, ... }:

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  
  # Configure X keyboard
  services.xserver.layout = "fr";
  services.xserver.xkbVariant = "bepo";

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Display manager
  services.xserver.displayManager.autoLogin = {
    enable = true;
    user = config.users.users.jtremesay.name;
   };
  services.xserver.displayManager.sddm.enable = true;

  # Deskop manager
  services.xserver.desktopManager.plasma5.enable = true;
}
