{ config, lib, pkgs, modulesPath, ... }:

{
  nixpkgs = {
    config.allowUnfree = true;
    overlays = [(
      self: super: {
        steam = super.steam.override {
          extraPkgs = pkgs: with pkgs; [ 
	    libpng 
	    icu 
          ];
        };
      }
    )];
  };
  environment.systemPackages = with pkgs; [
    bind
    curl
    httpie
    jq
  ];
 
  programs.fish.enable = true;
  programs.git.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  programs.htop.enable = true;
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };
  programs.steam = {
    enable = true;
  };
  programs.tmux.enable = true;
}
