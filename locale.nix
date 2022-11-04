{ config, lib, pkgs, modulesPath, ... }:

{
  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "fr-bepo";
  };
}
