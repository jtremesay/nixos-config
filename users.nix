{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ ./users/jtremesay/user.nix ];

  users = { defaultUserShell = pkgs.fish; };
}
