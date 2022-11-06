{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ ./services/locate.nix ./services/ssh.nix ];
}
