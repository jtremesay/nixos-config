

{ config, lib, pkgs, modulesPath, ... }: {
  home-manager.users.jtremesay = {
    nixpkgs.config.allowUnfree = true;
    home = {
      packages = with pkgs; [ direnv python39Packages.ipython ];
      sessionPath = [  "\${HOME}/.cargo/bin" "\${HOME}/.local/bin" ];
      sessionVariables = {
        EDITOR = "nvim";
        PAGER = "less";
        VISUAL = "nvim";
      };
    };
    programs = {
      git = {
        enable = true;
        userEmail = "jonathan.tremesaygues@slaanesh.org";
        userName = "Jonathan Tremesaygues";
        extraConfig = {
          init = { defaultBranch = "main"; };
          safe = { directory = "/etc/nixos"; };
        };
      };
      neovim = {
        coc.enable = true;
        extraPython3Packages = (ps: with ps; [ python-lsp-server ]);
        plugins = with pkgs.vimPlugins; [
          {
            plugin = nvim-base16;
            config = ''
              set background = "dark"
              colorscheme base16-monokai
              let base16colorspace = 256  " Access colors present in 256 colorspace
              set termguicolors
            '';
          }
          {
            plugin = nerdtree;
            config = "map <C-n> :NERDTreeToggle<CR>";
          }
          {
            plugin = vim-airline;
            config = ''
              let g:airline_theme='base16_helios'
              let g:airline#extensions#ale#enabled = 1
            '';
          }
          vim-airline-themes
        ];
        extraConfig = ''
          " Use actual tab chars in Makefiles.
          autocmd FileType make set tabstop=4 shiftwidth=4 softtabstop=0 noexpandtab
          " Indent size 2 for YAML
          autocmd FileType yaml set tabstop=2 shiftwidth=2 softtabstop=2 expandtab
          " For everything else, use a tab width of 4 space chars.
          set tabstop=4      " The width of a TAB is set to 4.
                             " Still it is a \t. It is just that
                             " Vim will interpret it to be having
                             " a width of 4.
          set shiftwidth=4   " Indents will have a width of 4.
          set softtabstop=4  " Sets the number of columns for a TAB.
          set expandtab      " Expand TABs to spaces.
          set mouse=a        " Enable mouse stroll
          set number         " Enable line numbering
          set colorcolumn=80 " Add a ruler
        '';
        viAlias = true;
        vimAlias = true;
        vimdiffAlias = true;
      };
    };
  };
}
