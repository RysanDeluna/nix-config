{ config, pkgs, ...}:
let
  myAliases = {
    ll = "ls -l";
    ".." = "cd ..";
  };
in
{
  programs = {
    bash = {
      enable = true;
      shellAliases = myAliases;
    };
    zsh = {
      enable = true;
      shellAliases = myAliases;
    };
  };
}
