{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    ./x.nix
    ./sound.nix
  ];
}
