

{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ <home-manager/nixos> ];

  home-manager.users.jtremesay = { pkgs, ... }: {
    nixpkgs.config.allowUnfree = true;
    home = {
      packages = with pkgs; [
        deltachat-desktop
        filelight
        i3lock
        keepassxc
        libreoffice-qt
        libsForQt5.kpat
        lutris
        nextcloud-client
        pcmanfm
	pulseaudio
	pulsemixer
        python39Packages.ipython
        thunderbird
        vscode-with-extensions
      ];
      sessionPath = [ "\${HOME}/.local/bin" ];
      sessionVariables = {
        EDITOR = "nvim";
        PAGER = "less";
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
      rofi = {
        enable = true;
        extraConfig = { modi = "drun,run,window"; };
      };
    };
    xsession = {
      enable = true;
      initExtra = ''
        xsetroot -grey

        # No sure why, but i3 doesn't take in account global settings
        setxkbmap -layout ${config.services.xserver.layout} -variant ${config.services.xserver.xkbVariant}
      '';
      windowManager = {
        i3 = {
          enable = true;
          config = {
            keybindings = {
              # i3 management
              "Mod4+Shift+x" = "reload";
              "Mod4+Shift+o" = "restart";
              "Mod4+Shift+p" = "exec i3-msg exit";

              # Lock session
              "Ctrl+Shift+l" = "exec i3lock";

              # Multimedia keys
              "XF86AudioRaiseVolume" =
                "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +10% && $refresh_i3status";
              "XF86AudioLowerVolume" =
                "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -10% && $refresh_i3status";
              "XF86AudioMute" =
                "exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle && $refresh_i3status";
              "XF86AudioMicMute" =
                "exec --no-startup-id pactl set-source-mute @DEFAULT_SOURCE@ toggle && $refresh_i3status";

              # Programs
              "Mod4+Return" = "exec xterm";
              "Mod4+w" = "exec firefox";
              "Mod4+f" = "exec pcmanfm";
              "Mod4+i" = "exec --no-startup-id rofi -show";

              # Window management
              "Mod4+Shift+b" = "kill";
              "Mod4+Left" = "focus left";
              "Mod4+Down" = "focus down";
              "Mod4+Up" = "focus up";
              "Mod4+Right" = "focus right";
              "Mod4+Shift+Left" = "move left";
              "Mod4+Shift+Down" = "move down";
              "Mod4+Shift+Up" = "move up";
              "Mod4+Shift+Right" = "move right";
              "Mod4+h" = "split h";
              "Mod4+v" = "split v";
              "Mod4+e" = "fullscreen toggle";
              "Mod4+u" = "layout stacking";
              "Mod4+y" = "layout tabbed";
              "Mod4+p" = "layout toggle split";

              # Workspace management
              "Mod4+0" = "workspace number 10";
              "Mod4+1" = "workspace number 1";
              "Mod4+2" = "workspace number 2";
              "Mod4+3" = "workspace number 3";
              "Mod4+4" = "workspace number 4";
              "Mod4+5" = "workspace number 5";
              "Mod4+6" = "workspace number 6";
              "Mod4+7" = "workspace number 7";
              "Mod4+8" = "workspace number 8";
              "Mod4+9" = "workspace number 9";
              "Mod4+Shift+0" = "move container to workspace number 10";
              "Mod4+Shift+1" = "move container to workspace number 1";
              "Mod4+Shift+2" = "move container to workspace number 2";
              "Mod4+Shift+3" = "move container to workspace number 3";
              "Mod4+Shift+4" = "move container to workspace number 4";
              "Mod4+Shift+5" = "move container to workspace number 5";
              "Mod4+Shift+6" = "move container to workspace number 6";
              "Mod4+Shift+7" = "move container to workspace number 7";
              "Mod4+Shift+8" = "move container to workspace number 8";
              "Mod4+Shift+9" = "move container to workspace number 9";
            };
          };
        };
      };
    };
  };
}
