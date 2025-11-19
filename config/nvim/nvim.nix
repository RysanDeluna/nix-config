pkgs:
{
  enable = true;
  vimAlias = true;
  extraConfig = ''
    luafile $NVIM_CONFIG_DIR/lua/settings.lua
    luafile $NVIM_CONFIG_DIR/lua/treesitter.lua

    lua << EOF
      vim.defer_fn(function()
        vim.cmd [[
          luafile $NVIM_CONFIG_DIR/lua/lsp.lua
        ]]
      end, 70)
    EOF
  '';
  /* source $NVIM_CONFIG_DIR/colors/scheme.vim */

  plugins = with pkgs.vimPlugins; [
    indentLine

    # File tree
    nvim-web-devicons
    nvim-tree-lua

    # lsp
    nvim-lspconfig
    nvim-cmp
    cmp-buffer
    cmp-path
    cmp_luasnip
    cmp-nvim-lsp

    # Eye candy
    nvim-treesitter.withAllGrammars

    vim-nix
    
  ];
}
