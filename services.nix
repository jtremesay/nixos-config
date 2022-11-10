{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ ./services/fwupd.nix ./services/locate.nix ./services/ssh.nix ];
}
