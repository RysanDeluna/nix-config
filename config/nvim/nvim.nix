# https://github.com/nix-community/home-manager/blob/master/modules/programs/neovim.nix
# The plugins can be directed to their dotfiles within the plugins declarations, observe the definition for pluginWithConfigType

pkgs:
{
  enable = true;
  vimAlias = true;

  extraPackages = with pkgs; [  # Dependencies
    # TS
    tree-sitter

    # LSP
    lua-language-server
    nixd

    # format
    stylua
    nixfmt

    # Telescope
    ripgrep
    fd
  ];

  extraLuaConfig = ''
    ${builtins.readFile ./lua/settings.lua}
  '';

  plugins = with pkgs.vimPlugins; [
    vim-sensible

    { # Para ver atalhos
      plugin = which-key-nvim;
      type = "lua";
      config = builtins.readFile ./lua/which-key-config.lua;
    }

    { # File Tree
      plugin = nvim-tree-lua;
      type = "lua";
      config = builtins.readFile ./lua/filetree.lua;
    }

    { # lsp-config 
      plugin = nvim-lspconfig;
      type = "lua";
      config = builtins.readFile ./lua/lsp.lua;
    }

    { # lps status window 
      plugin = fidget-nvim;
      type = "lua";
      config = builtins.readFile ./lua/fidget-config.lua; 
    }

    luasnip
    { # blink autocompletion
      plugin = blink-cmp;
      type = "lua";
      config = builtins.readFile ./lua/blink-config.lua;
    }

    { # Status bar
      plugin = lualine-nvim;
      type = "lua";
      config = builtins.readFile ./lua/lualine-config.lua;
    }

    { # git info
      plugin = gitsigns-nvim;
      type = "lua";
      config = builtins.readFile ./lua/gitsigns-config.lua;
    }

    {
      plugin = conform-nvim;
      type = "lua";
      config = builtins.readFile ./lua/conform-config.lua;
    }

    nvim-colorizer-lua
    plenary-nvim
    nvim-web-devicons
    telescope-fzf-native-nvim
    telescope-ui-select-nvim
    { # Telescope
      plugin = telescope-nvim;
      type = "lua";
      config = builtins.readFile ./lua/telescope-config.lua;
    }

    # ------------ Eye candy ---------------
    indentLine
    nvim-treesitter.withAllGrammars
    vim-nix


    { # ---------- COLORSCHEMES ------------
      plugin = nordic-nvim;
      type = "lua";
      config = builtins.readFile ./lua/colorschemes/nordic-config.lua;
    }

  ];
}
