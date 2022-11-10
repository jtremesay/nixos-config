{ config, lib, pkgs, modulesPath, ... }:

{
  environment.systemPackages = with pkgs; [ bind curl httpie jq nixfmt psmisc ];

  programs = {
    fish.enable = true;
    git.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    htop = {
      enable = true;
      settings = {
        hide_kernel_threads = true;
        hide_userland_threads = true;
      };
    };
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
    tmux.enable = true;
  };
}
