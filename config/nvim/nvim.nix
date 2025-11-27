pkgs:
{
  enable = true;
  vimAlias = true;
  extraConfig = ''
    luafile $NVIM_CONFIG_DIR/init.lua
  '';
  /* source $NVIM_CONFIG_DIR/colors/scheme.vim */

  plugins = with pkgs.vimPlugins; [
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
    indentLine
    nvim-treesitter.withAllGrammars
    lualine-nvim
    bufferline-nvim
    fidget-nvim
    gitsigns-nvim

    vim-nix
    
  ];
}
