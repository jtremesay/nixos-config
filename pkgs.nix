{ config, lib, pkgs, modulesPath, ... }:

{
  environment.systemPackages = with pkgs; [ bind curl httpie jq nixfmt ];

  programs.fish.enable = true;
  programs.git.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  programs.htop = {
    enable = true;
    settings = {
      hide_kernel_threads = true;
      hide_userland_threads = true;
    };
  };
    
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };
  programs.tmux.enable = true;
}
