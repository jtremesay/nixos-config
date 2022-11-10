

{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ <home-manager/nixos> ];

  users.users.jtremesay = {
    isNormalUser = true;
    extraGroups = [ "audio" "networkmanager" "wheel" ];
    useDefaultShell = true;
  };

  users.extraUsers.jtremesay = {
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC2QfuCeW4Pv+fZnlukbg844Z2P67m4ImBvdyNL7bPXdxH1FoAlWEbZpTvvZPXWNzHnrAQ63GEN07a0bzlbzG0ut/xHKBx/ltZcjcNQkQGB5ta2mewfKCQM/nAA2VdhwbZCa5VGJyCq3oj9HKaJ5RTHsSOSIvh7FQRbM/uAKUZHtfLzd7jBWwuyB/VSB1qSEO4yCHtYjvO4eEjur86fZNe+pHsejtuFN5HMh5QVMeud0VmbeB93L3M2die76u0Nd/Ea9q7/FkR4xR8a9OXAmp7PmCoB7/UlKufh6KvGeHE8xKl8Pibf/cpR56ViRvav660+TREQ9uxoi81S9r4qCOUUEEsuAIaVmGTsKeZ1zSWG3PGwTtIgMOxpCXF1FhSHcIvMh4JNkykzdG6Ul76kDEw6Tdc2cE6uA+o7jnVo3TDrSM5ZYE1ZrRlCz1SWRspx04GUxrjWNTd3wkiAx6vliKMM9/2FdzZRgDk4hlbQgoi1jO7TK/KZQKTaWBbIyTDgGNXQZjhM5fwW2LrmLymD6OXJo4qGLZwD51X+TX0JJZrxmUlsTNQE852o0snEl/rqojsp0+dn3x3Zti868kINTNF0PNcO/HgqwLqk67K3JcFlJNV+sVshUtW7gjHaqZ+Fpe4vV5mECQ2qrSw/ulr8EmeMaPsve9hltE2qnYSZaQSq0Q== killruana@edemaruh.slaanesh.org"
    ];
  };

  home-manager.users.jtremesay = { pkgs, ... }: {
    nixpkgs.config.allowUnfree = true;
    home = {
      packages = with pkgs; [
        deltachat-desktop
        filelight
        keepassxc
        libreoffice-qt
        libsForQt5.kpat
        lutris
        nextcloud-client
        python39Packages.ipython
        thunderbird
        vscode-with-extensions
      ];
      sessionPath = [ "\${HOME}/.local/bin" ];
      sessionVariables = {
        EDITOR = "nvim";
        PAGER = "LESS";
        VISUAL = "nvim";
      };
      file = {
        xresources = {
          source = ./Xresources;
          target = ".Xresources";
        };
      };
    };
    xdg.enable = true;
    programs = {
      firefox.enable = true;
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
    xsession = {
      enable = true;
      initExtra = ''
        xsetroot -grey

        # No sure why, but i3 doesn't take in account global settings
        setxkbmap -layout ${config.services.xserver.layout} -variant ${config.services.xserver.xkbVariant}
      '';
      windowManager = { i3 = { enable = true; }; };
    };
  };
}
