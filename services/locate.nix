{ config, lib, pkgs, modulesPath, ... }:

{
  services.locate = {
    enable = true;
    interval = "hourly";
  };
}
