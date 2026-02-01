{ config, pkgs, ... }:


let
  customNeovim = import ./config/nvim/nvim.nix;
in
{
  home = {
    username = "ni";
    homeDirectory = "/home/ni";
    stateVersion = "25.05";
    sessionVariables = {
      EDITOR = "nvim";
      NVIM_CONFIG_DIR = "${config.home.homeDirectory}/.dotfiles/config/nvim";
    };
  };

  home.file = {
    # mutable files, edit the config and doesnt need to rebuild
    ".config/waybar/style.css".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/config/waybar/style.css";
  };
  xdg.configFile."nvim" = {
    recursive = true;
    source = ./config/nvim;
  };

  home.pointerCursor = {
    name = "Nordic-cursors";
    package = pkgs.nordic;
    size = 24;                    
    gtk.enable = true;           
    x11.enable = true;          
  };

  gtk = {
    enable = true;
    theme = {
      name = "Nordic";
      package = null;
    };
  };

  wayland = {
    windowManager.hyprland = {
      enable = true;
      package = null;
      portalPackage = null;
      systemd.variables = ["--all"];
      settings = {
        general = {
          gaps_in = 5;
          gaps_out = 10;
          border_size = 2; 

          "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 60deg";
          "col.inactive_border" = "rgba(595959aa)";

          resize_on_border = false;
          layout = "dwindle";
        };

        decoration = {
          rounding = 0; 
          active_opacity = 1.0;
          inactive_opacity = 0.98; 

          shadow = {
            enabled = true;
            range = 2;
            render_power = 3;
            color = "rgba(1a1a1aee)";
          };

          blur = {
            enabled = false;
            size = 3;
            passes = 1;
            vibrancy = 0.1696;
          };
        };

        animations = {
          enabled = true;
          bezier = [
            "easeOutQuint,0.23,1,0.32,1"
            "easeInOutCubic,0.65,0.05,0.36,1"
            "linear,0,0,1,1"
            "almostLinear,0.5,0.5,0.75,1.0"
            "quick,0.15,0,0.1,1"
          ];
          animation = [
            # Name	    	# on	# speed # curve		# etc
            "global, 		1, 	10,	default				"
            "border, 		1, 	5.39, 	easeOutQuint			"
            "windows, 		1, 	4.79, 	easeOutQuint			"
            "windowsIn, 	1, 	4.1, 	easeOutQuint,	popin 87%	" 
            "windowsOut,	1, 	1.49,	linear, 	popin 87%	" 
            "fadeIn, 		1, 	1.73,	almostLinear			"
            "fadeOut, 		1, 	1.46,	almostLinear			"
            "fade, 		1, 	3.03,	quick				"
            "layers, 		1, 	3.81,	easeOutQuint			"
            "layersIn, 		1, 	4, 	easeOutQuint, 	fade		"
            "layersOut, 	1, 	1.5, 	linear, 	fade		"
            "fadeLayersIn, 	1, 	1.79, 	almostLinear			"
            "fadeLayersOut, 	1, 	1.39, 	almostLinear			"
            "workspaces,	0,	0,	ease				"
          ];
        };

        dwindle = {
          pseudotile = true;
          preserve_split = true;
          force_split = 2; 
        };

        master.new_status = "master";

        misc = {
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
          focus_on_activate = true; 
        };

        "$terminal" = "foot";
        "$fileManager" = "nautilus --new-window";
        "$menu" = "wofi --show drun";
        "$mod" = "SUPER";

        exec-once = [
          "waypaper --restore"
          "waybar"
          "mako"
        ];

        monitor = "Virtual-1,1440x900@59,0x0,1";
        env = [
          "GDK_BACKEND,wayland,x11,*"
          "QT_STYLE_OVERRIDE,kvantum"
          "SDL_VIDEODRIVER,wayland"
          "MOZ_ENABLE_WAYLAND,1"
          "ELECTRON_OZONE_PLATFORM_HINT,wayland"
          "OZONE_PLATFORM,wayland"
          "GSK_RENDERER,vulkan"
          "XDG_SESSION_TYPE,wayland"

          "XDG_CURRENT_DESKTOP,Hyprland"
          "XDG_SESSION_DESKTOP,Hyprland"
        ];
        xwayland.force_zero_scaling = true;
        ecosystem.no_update_news = true;

        input = {
          # keyboard ---------
          kb_layout = "br";

          # mouse ------------ 
          follow_mouse = 2;
          sensitivity = 0;
          touchpad = { natural_scroll = false; };
        };

        cursor = { 
          enable_hyprcursor = false;
              inactive_timeout = 10;
          no_warps = true;
        };

        bindmd = [
          "$mod, mouse:272, Move Window, movewindow"
          "$mod, mouse:273, Resize Window, resizewindow"
            ];

        bindd = [
          # MODs,	KEY,	DESCR		DISPATCHER,	params
          "$mod,	W,	Close active,	killactive			"
          "$mod,	M,	Exit,		exit				"
          "$mod,	A,	Files,		exec,		$fileManager	"
          "$mod,	F11,	Fullscreen,	fullscreen,	1		"
          "$mod,	RETURN,	Terminal,	exec,		$terminal	"
          "$mod,	P,	dmenu	,	exec,		$menu		"

          "$mod,	V,	Floating, 	togglefloating,			"
          "$mod, 	F,	Force FS,	fullscreen,	0"

          "$mod,	j,	go down, 	movefocus,	d		"
          "$mod,	k,	go up	, 	movefocus,	u		"
          "$mod,	h,	go left	,	movefocus,	l		"
          "$mod,	l,	go right,	movefocus,	r		"

          "$mod CTRL,	j,	resize d,	resizeactive,	0 40		"
          "$mod CTRL,	k, 	resize u,	resizeactive,	0 -40		"
          "$mod CTRL,	h,	resize l,	resizeactive,	-40 0		"
          "$mod CTRL,	l,	resize r,	resizeactive,	40 0		"

          "$mod SHIFT,	j,	move d,		movewindow,	d		"
          "$mod SHIFT,	k,	move u,		movewindow,	u		"
          "$mod SHIFT,	h,	move l,		movewindow,	l		"
          "$mod SHIFT,	l,	move r,		movewindow,	r		"
          
          "$mod SHIFT,	1,	Move Window to,	movetoworkspace,1		"
          "$mod SHIFT,	2,	Move Window to,	movetoworkspace,2		"
          "$mod SHIFT,	3,	Move Window to,	movetoworkspace,3		"
          "$mod SHIFT,	4,	Move Window to,	movetoworkspace,4		"
          "$mod SHIFT,	5,	Move Window to,	movetoworkspace,5		"
          "$mod SHIFT,	6,	Move Window to,	movetoworkspace,6		"
          "$mod SHIFT,	7,	Move Window to,	movetoworkspace,7		"
          "$mod SHIFT,	8,	Move Window to,	movetoworkspace,8		"
          "$mod SHIFT,	9,	Move Window to,	movetoworkspace,9		"
          "$mod SHIFT,	0,	Move Window to,	movetoworkspace,10		"

          "$mod,	1,	goto WS,	workspace,	1		"
          "$mod,	2,	goto WS,	workspace,	2		"
          "$mod,	3,	goto WS,	workspace,	3		"
          "$mod,	4,	goto WS,	workspace,	4		"
          "$mod,	5,	goto WS,	workspace,	5		"
          "$mod,	6,	goto WS,	workspace,	6		"
          "$mod,	7,	goto WS,	workspace,	7		"
          "$mod,	8,	goto WS,	workspace,	8		"
          "$mod,	9,	goto WS,	workspace,	9		"
          "$mod,	0,	goto WS,	workspace,	10		"

          "$mod,	TAB,	Next Workspace,	workspace,	e+1		"
          "$mod SHIFT,	TAB,	Next Workspace,	workspace,	e-1		"
          "$mod CTRL,	TAB,	Next Workspace,	workspace,	previous	"
        ];
      };
    };
  };


  services = {
    mako.enable = true;
    swww = { 
      enable=true; 
    };
  };
  

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.tree
    pkgs.hello
    pkgs.nordic            # theme
    pkgs.rose-pine-cursor  # Cursor pack
    pkgs.waypaper          # Wallpaper
    pkgs.swww              # Wallpaper
    pkgs.dconf-editor      # GTK editor
    pkgs.nwg-look          # theming
    pkgs.nautilus          # file manager

    # LSPs
    pkgs.nixd
    pkgs.lua-language-server

    # Utils
    pkgs.wl-clipboard
    pkgs.gcc

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  programs = {
    home-manager.enable = true;

    # Utils
    ripgrep.enable = true;
    fd.enable = true;

    git = {
      enable = true;
      userName = "RysanDeluna";
      userEmail = "ry.marco.andrade@gmail.com";
      extraConfig = {
	    init.DefaultBranch = "main";
      };
    };

    bash = {
      enable = true;
      shellAliases = {
        ll = "ls -l";
        ".." = "cd ..";
      };
    };

    foot.enable = true;
    waybar = {
      enable = true;
      settings = {
        crazy-main-bar = {
          layer = "top";
          output = [ "Virtual-1" ];
          position = "top"; 
          height = 30;
          # width = ; 
          reload_style_on_change = true;

          # ORGANISATION -------------------------------------

          modules-left = [ "custom/text" "hyprland/workspaces" "hyprland/window" ];
          modules-center = [ "clock" ];
          modules-right = [ "group/audio" "network" "privacy" "backlight/slider" 
                            "group/hardware" "group/power-group"];

          # GROUPS -------------------------------------------

          "group/hardware" = {
            orientation = "horizontal";
            modules = [
              "cpu" "memory" "temperature" 
            ];
            drawer = {
              transition-durantion = 500;
              children-class = "drawer-1";
              transition-left-to-right = true;
                  click-to-reveal = true;
            };
	      };

          "group/power-group" = {
            orientation = "horizontal";
            modules = ["custom/power" "custom/reboot" "custom/quit" ];
            drawer = {
              transition-duration = 400;
	          children-class = "not-power";
              transition-left-to-right = false;
            };
          };

          "group/audio" = {
            orientation = "horizontal";
            modules = ["pulseaudio" "pulseaudio/slider"];
            drawer = {
              transition-durantion = 600;
              children-class = "drawer-2";
              transition-to-left = true;
              click-to-reveal = true;
            };
	      };

          # MODULES CONFIG ----------------------------------- 
          "custom/quit" = {
            format = "󰗼"; tooltip = false; on-click = "hyprctl dispatch exit"; 
          };
          #"custom/lock" = {
              #  format = "󰍁"; tooltip = false; on-click = ""
          #};
          "custom/reboot" = {
                format = "󰜉"; tooltip = false; on-click = "reboot";
          };
          "custom/power" = {
                format = ""; tooltip = false; on-click = "shutdown now";
          };

          memory = {
            interval = 5; rotate = 0; format = "{icon}";
            format-icons = ["󰝦" "󰪞" "󰪟" "󰪠" "󰪡" "󰪢" "󰪣" "󰪤" "󰪥"];
            max-length = 10; 
          };

          cpu = {
            interval = 5; rotate = 0; format = "{icon}";
            format-icons = ["󰝦" "󰪞" "󰪟" "󰪠" "󰪡" "󰪢" "󰪣" "󰪤" "󰪥"];
            max-length = 10; 
          };

          temperature = {
            interval  = 1; critical-threshold = 85; 
            format = "{icon}";
            format-icons = ["" "" "" "" ""];
          };

	      "custom/text" = { format = "  Hey there, Samurai.; "; };

          "hyprland/workspaces" = {
            format = "{icon}";
            icon-size = 18;
            format-icons = {
              active = "";
              default = "";
            };
            persistent-workspaces = { "*" = 5; };
          };

          "hyprland/window" = {
            format = "<span  weight='bold' >{class}</span>";
            max-length = 120;
            icon   = false;
            icon-size = 24;
            separate-outputs = true;
            rewrite = {  # FIXME
              "(.*)Mozilla Firefox" = "󰯊 $1";
              "vim (.*)" = " $1";
              "foot (.*)" = " $1";
            };
          };

          network = {
            tooltip = true; 
            format-wifi = "{icon} "; 
            format-icons = ["󰤟" "󰤢" "󰤥"];
            format-ethernet= "󰈀 ";
            tooltip-format = "Network: <big><b>{essid}</b></big>\nSignal strength: <b>{signaldBm}dBm ({signalStrength}%)</b>\nFrequency: <b>{frequency}MHz</b>\nInterface: <b>{ifname}</b>\nIP: <b>{ipaddr}/{cidr}</b>\nGateway: <b>{gwaddr}</b>\nNetmask: <b>{netmask}</b>";
            format-linked = "󰈀 {ifname} (No IP)";
            format-disconnected =  " ";
            tooltip-format-disconnected = "Disconnected";
            interval = 2;
          };

          pulseaudio = {
            format = "{icon}";
            rotate = 0; 
            format-muted = "婢";
            tooltip-format = "{icon} {desc} // {volume}%";
            scroll-step = 5;
            format-icons = {
              default =  ["" "" ""];
              headphone = "";
              hands-free =  "";
              headset = "";
              phone = "";
              portable =  "";
              car = "";
            };
          };
          "pulseaudio/slider"  = {
            min = 5; max = 100;
            rotate = 0; 
            device = "pulseaudio";
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
                months=     "<span color='#ffead3'><b>{}</b></span>";
                days=       "<span color='#ecc6d9'><b>{}</b></span>";
                weeks=      "<span color='#99ffdd'><b>W{}</b></span>";
                weekdays=   "<span color='#ffcc66'><b>{}</b></span>";
                today=      "<span color='#ff6699'><b><u>{}</u></b></span>";
              };
            };
            actions = {
              on-click-right = "mode";
              on-scroll-up = "shift_down";
              on-scroll-down="shift_up";
            };
          };
        };
      };
    };
    wofi = {
      enable = true;
    };
    eww = {
      enable = true;
    };

    neovim = customNeovim pkgs;

    cava = {  # FIXME
      enable = true;
      settings = {
        general = {
          mode = "normal";
          framerate = 30;
          autosens = 1;
          overshoot = 20; 
          bars = "auto";
        };
        input = {
          method = "pipewire";
          source = "auto";
        };
      };
    };
  };
}
