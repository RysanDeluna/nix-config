{ config, pkgs, ... }:
let
  customNeovim = import ./config/nvim/nvim.nix;
in
{
  nixpkgs.config.allowUnfree = true;

  imports = [
    ./config/terminal
    ./config/wm
  ];
  home = {
    username = "ni";
    homeDirectory = "/home/ni";
    stateVersion = "25.11";
    sessionVariables = {
      EDITOR = "nvim";
      NVIM_CONFIG_DIR = "${config.home.homeDirectory}/.dotfiles/config/nvim";
    };
    sessionPath = [
      "${config.home.homeDirectory}/.dotfiles/scripts"
    ];
    file = {
      # mutable files, edit the config and doesnt need to rebuild
      ".config/waybar/style.css".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/config/bar/style.css";
    };

    pointerCursor = {
      name = "Nordic-cursors";
      package = pkgs.nordic;
      size = 24;
      gtk.enable = true;
      x11.enable = true;
    };

    packages = [
      pkgs.tree
      pkgs.hello
      pkgs.nordic # theme
      pkgs.rose-pine-cursor # Cursor pack
      pkgs.waypaper # Wallpaper
      pkgs.swww # Wallpaper
      pkgs.dconf-editor # GTK editor
      pkgs.nwg-look # theming
      pkgs.nautilus # file manager
      pkgs.pwvucontrol

      # LSPs
      pkgs.nixd
      pkgs.lua-language-server

      # Utils
      pkgs.wl-clipboard
      pkgs.gcc
      pkgs.jtbl
    ];
  };

  xdg.configFile."nvim" = {
    recursive = true;
    source = ./config/nvim;
  };

  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.nordzy-icon-theme;
      name = "Nordzy-cyan-dark";
    };
    theme = {
      name = "Nordic";
      package = null;
    };
  };

  services = {
    mako.enable = true;
    clipse.enable = true;
    flameshot.enable = true;
    udiskie.enable = true;
    swww = {
      enable = true;
    };
    network-manager-applet.enable = true;
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  programs = {
    home-manager.enable = true;

    # CLI
    foot = {
      enable = true;
      settings = {
        main = {
          font = "monospace:size=14";
        };
      };
    };
    ripgrep.enable = true;
    fd.enable = true;
    btop.enable = true;
    fzf.enable = true;
    jq.enable = true;

    wofi.enable = true;
    eww.enable = true;
    neovim = customNeovim pkgs;

    git = {
      enable = true;
      settings = {
        user.name = "RysanDeluna";
        user.email = "ry.marco.andrade@gmail.com";
        init.DefaultBranch = "main";
      };
    };

    waybar = {
      enable = true;
      settings = {
        crazy-main-bar = {
          layer = "top";
          output = [ "eDP-1" ];
          position = "top";
          height = 30;
          # width = ;
          reload_style_on_change = true;

          # ORGANISATION -------------------------------------

          modules-left = [
            "custom/text"
            "hyprland/workspaces"
            "hyprland/window"
          ];
          modules-center = [ "clock" ];
          modules-right = [
            "group/audio"
            "group/backlight"
            "tray"
            "network"
            "privacy"
            "group/hardware"
            "battery"
            "group/power-group"
          ];

          # GROUPS -------------------------------------------
          tray = {
            spacing = 10;
          };

          "group/hardware" = {
            orientation = "horizontal";
            modules = [
              "cpu"
              "memory"
              "temperature"
            ];
            drawer = {
              transition-durantion = 500;
              children-class = "drawer-1";
              transition-left-to-right = true;
              click-to-reveal = true;
            };
          };

          battery = {
            interval = 30;
            states = {
              warning = 30;
              critical = 15;
            };
            format = "{capacity}% {icon}";
            format-icons = {
              default = [
                ""
                ""
                ""
                ""
                ""
              ];
            };
            max-length = 25;
          };

          "group/power-group" = {
            orientation = "horizontal";
            modules = [
              "custom/power"
              "custom/quit"
              "custom/reboot"
            ];
            drawer = {
              transition-duration = 400;
              children-class = "not-power";
              transition-left-to-right = false;
            };
          };

          "group/audio" = {
            orientation = "horizontal";
            modules = [
              "pulseaudio"
              "pulseaudio/slider"
            ];
            drawer = {
              transition-durantion = 600;
              children-class = "drawer-2";
              transition-to-left = true;
              start-expanded = true;
            };
          };

          "group/backlight" = {
            orientation = "horizontal";
            modules = [
              "backlight"
              "backlight/slider"
            ];
            drawer = {
              transition-durantion = 600;
              children-class = "drawer-3";
              transition-to-left = true;
              start-expanded = true;
            };
          };

          # MODULES CONFIG -----------------------------------
          "custom/quit" = {
            format = "󰗼";
            tooltip = false;
            on-click = "hyprctl dispatch exit";
          };
          #"custom/lock" = {
          #  format = "󰍁"; tooltip = false; on-click = ""
          #};
          "custom/reboot" = {
            format = "";
            tooltip = false;
            on-click = "reboot";
          };
          "custom/power" = {
            format = "";
            tooltip = false;
            on-click = "shutdown now";
          };

          memory = {
            interval = 5;
            rotate = 0;
            format = "{icon}";
            format-icons = [
              "󰝦"
              "󰪞"
              "󰪟"
              "󰪠"
              "󰪡"
              "󰪢"
              "󰪣"
              "󰪤"
              "󰪥"
            ];
            max-length = 10;
          };

          cpu = {
            interval = 5;
            rotate = 0;
            format = "{icon}";
            format-icons = [
              "󰝦"
              "󰪞"
              "󰪟"
              "󰪠"
              "󰪡"
              "󰪢"
              "󰪣"
              "󰪤"
              "󰪥"
            ];
            max-length = 10;
          };

          temperature = {
            thermal-zone = 2;
            interval = 1;
            critical-threshold = 70;
            format = "{icon}";
            format-icons = [
              ""
              ""
              ""
              ""
              ""
            ];
          };

          "custom/text" = {
            format = "  Hey there, Samurai.;";
          };

          "hyprland/workspaces" = {
            format = "{icon}";
            icon-size = 18;
            format-icons = {
              active = "";
              default = "";
            };
            persistent-workspaces = {
              "*" = 5;
            };
          };

          "hyprland/window" = {
            format = "<span  weight='bold' >{class}</span>";
            max-length = 120;
            icon = false;
            icon-size = 24;
            separate-outputs = true;
          };

          network = {
            tooltip = true;
            format-wifi = "{icon} ";
            format-icons = [
              "󰤟"
              "󰤢"
              "󰤥"
            ];
            format-ethernet = "󰈀";
            tooltip-format = "Network: <big><b>{essid}</b></big>\nSignal strength: <b>{signaldBm}dBm ({signalStrength}%)</b>\nFrequency: <b>{frequency}MHz</b>\nInterface: <b>{ifname}</b>\nIP: <b>{ipaddr}/{cidr}</b>\nGateway: <b>{gwaddr}</b>\nNetmask: <b>{netmask}</b>";
            format-linked = "󰈀 {ifname} (No IP)";
            format-disconnected = "";
            tooltip-format-disconnected = "Disconnected";
            interval = 2;
            on-click = "nm-connection-editor";
          };

          backlight = {
            format = "{icon}";
            format-icons = [ "" ];
          };
          "backlight/slider" = {
            min = 10;
            max = 100;
          };

          pulseaudio = {
            format = "{icon}";
            rotate = 0;
            format-muted = "󰝟";
            tooltip-format = "{icon} {desc} // {volume}%";
            scroll-step = 5;
            format-icons = {
              default = [
                " "
                " "
                " "
              ];
              headphone = "";
              hands-free = "";
              headset = "";
              phone = "";
              portable = "";
              car = "";
            };
            on-click-right = "pwvucontrol";
          };
          "pulseaudio/slider" = {
            min = 0;
            max = 100;
            rotate = 0;
            scroll-step = 1;
          };

          clock = {
            format = "{:%H:%M }";
            interval = 60;
            timezone = "America/Sao_Paulo";

            tooltip-format = "<tt><small>{calendar}</small></tt>";
            calendar = {
              mode = "month";
              mode-mon-col = 4;
              format = {
                months = "<span color='#ffead3'><b>{}</b></span>";
                days = "<span color='#ecc6d9'><b>{}</b></span>";
                weeks = "<span color='#99ffdd'><b>W{}</b></span>";
                weekdays = "<span color='#ffcc66'><b>{}</b></span>";
                today = "<span color='#ff6699'><b><u>{}</u></b></span>";
              };
            };
            actions = {
              on-click-right = "mode";
              on-scroll-up = "shift_down";
              on-scroll-down = "shift_up";
            };
          };
        };
      };
    };

    discord.enable = true;
    obsidian.enable = true;
  };
}
