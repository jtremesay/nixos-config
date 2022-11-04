{ config, lib, pkgs, modulesPath, ... }:

{
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;
}
