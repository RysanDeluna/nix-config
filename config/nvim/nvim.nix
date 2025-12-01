# https://github.com/nix-community/home-manager/blob/master/modules/programs/neovim.nix
# The plugins can be directed to their dotfiles within the plugins declarations, observe the definition for pluginWithConfigType

pkgs:
{
  enable = true;
  vimAlias = true;

  extraPackages = with pkgs; [
    # TS
    tree-sitter

    # LSP
    lua-language-server
    nixd

    # Telescope
    ripgrep
    fd
  ];

  extraLuaConfig = ''
    ${builtins.readFile ./lua/settings.lua}
  '';

  plugins = with pkgs.vimPlugins; [
    # File tree
    vim-sensible
    nvim-web-devicons

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

    # Eye candy
    indentLine
    nvim-treesitter.withAllGrammars
    vim-nix
  ];
}
