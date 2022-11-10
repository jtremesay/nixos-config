{ config, lib, pkgs, modulesPath, ... }:

{
  services = {
    # Enable the X11 windowing system.
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
	session = [
          {
	    manage = "desktop";
	    name = "XSession";
	    start = ''exec $HOME/.xsession'';
	  }
	];
      };

      # Deskop manager
      desktopManager.plasma5.enable = true;
    };
  };
}
