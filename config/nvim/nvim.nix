pkgs:
{
  enable = true;
  vimAlias = true;
  extraConfig = ''
    luafile $NIXOS_CONFIG_DIR/config/nvim/settings.lua
  '';

  plugins = with pkgs.vimPlugins; [
  
  ];
}
