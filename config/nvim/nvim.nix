pkgs:
{
  enable = true;
  vimAlias = true;
  extraConfig = ''
    luafile $NVIM_CONFIG_DIR/lua/settings.lua
    luafile $NVIM_CONFIG_DIR/lua/treesitter.lua
  '';
  /* source $NVIM_CONFIG_DIR/colors/scheme.vim */

  plugins = with pkgs.vimPlugins; [
    indentLine

    # File tree
    nvim-web-devicons
    nvim-tree-lua

    # Eye candy
    nvim-treesitter

    vim-nix
    
  ];
}
