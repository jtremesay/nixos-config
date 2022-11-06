# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [ ../base.nix ../desktop.nix ../users.nix ];

  # Encrypted root
  boot.initrd.luks.devices.crypted = {
    device = "/dev/disk/by-uuid/5819e617-8899-4e6e-a4f1-4986a6e3bc8e";
    allowDiscards = true;
    bypassWorkqueues = true;
  };

  # Network
  networking.hostName = "music";
  networking.networkmanager.enable = true;
}

