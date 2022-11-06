# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [ ../base.nix ../desktop.nix ../nvidia.nix ../users.nix ];

  # Encrypted root
  boot.initrd.luks.devices = {
    edemaruh0 = {
      device = "/dev/disk/by-uuid/9340ee3c-9bdf-4cb8-bbe4-3f11eb3efb18";
      allowDiscards = true;
      bypassWorkqueues = true;
    };
    edemaruh1 = {
      device = "/dev/disk/by-uuid/fa815330-be8d-4449-ac59-6a41fc5574fe";
      allowDiscards = true;
      bypassWorkqueues = true;
    };
    swap0 = {
      device = "/dev/disk/by-uuid/d2b67e2e-0376-4e8e-867b-3592ffcc64b5";
      allowDiscards = true;
      bypassWorkqueues = true;
    };
    swap1 = {
      device = "/dev/disk/by-uuid/1fabd338-a76e-4992-948e-e51ce80e39b1";
      allowDiscards = true;
      bypassWorkqueues = true;
    };
  };

  # Network
  networking.hostName = "edemaruh";
}

