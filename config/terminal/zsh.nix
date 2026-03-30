{ config, pkgs, ... }:
let
  myAliases = {
    ll = "ls -l";
    ".." = "cd ..";
    dot = "cd ~/.dotfiles";
    edot = "nvim ~/.dotfiles"; # edit dotfiles
    hmsf = "home-manager switch --flake";
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
      enableCompletion = true;
      autocd = true;
      autosuggestion.enable = true;
      oh-my-zsh = {
        enable = true;
        theme = "half-life";
        plugins = [
          "aliases"
          "git"
          "themes"
          "colored-man-pages"
          "direnv"
        ];
      };
    };
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
      silent = true;
    };
  };
}
