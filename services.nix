{ config, lib, pkgs, modulesPath, ... }:

{
  services.openssh = {
  	enable = true;
	startWhenNeeded = true;
	passwordAuthentication = false;
  };
  services.locate = {
  	enable = true; 
	interval = "hourly";
  };
}
