{ config, lib, pkgs, modulesPath, ... }:

{
  services.openssh = {
  	enable = true;
	startWhenNeeded = true;
	kbdInteractiveAuthentication = false;
	passwordAuthentication = false;
  };
  services.locate = {
  	enable = true; 
	interval = "hourly";
  };
}
