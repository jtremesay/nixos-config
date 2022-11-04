{ config, lib, pkgs, modulesPath, ... }:

{
  networking = {
    domain = "slaanesh.org";
    search = [ config.networking.domain ];
    nameservers = [
      "9.9.9.9"
      "149.112.122.122"
      "[2620:fe::fe]"
      "[2620:fe::9]"
    ];
  };
  services.resolved.enable = true;
}
