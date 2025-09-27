{ config, pkgs, lib, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "ni";
  home.homeDirectory = "/home/ni";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    pkgs.hello

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

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/ni/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  wayland = {
    windowManager.hyprland = {
      enable = true;
      package = null;
      portalPackage = null;
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
	  inactive_opacity = 0.95; 

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
	"$fileManager" = "nautilus";
	"$menu" = "wofi --show drun";
	"$mod" = "SUPER";

	exec-once = [
	  "waybar 2>&1 > ~/logwaybar"
	  "mako 2>&1 > ~/logmako"
	  "waypaper --restore"
	  "$terminal"
	];

	monitor = "Virtual-1,1240x720@59,0x0,1";
	env = [
          "XCURSOR_SIZE,24"
	  "HYPRCURSOR_SIZE,24"
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
      package=null; 
    };
  };
  
  programs = {
    home-manager.enable = true;

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
	  position = "top"; 
	  height = 30;
	  output = [ "Virtual-1" ];
	  reload_style_on_change = true;

	  modules-left = [ "tray" ];
	  modules-center = [ "hyprland/workspaces" ];
	  modules-right = [ "pulseaudio" "network" "clock" "power"];

	  "hyprland/workspaces" = {
            format = "{icon}";
	    format-icons = {
              active = "";
	      default = "";
	      empty = "";
	    };
	    persistent-workspaces = { "*" = [ 1 2 3 4 5 ]; };
	  };
	  clock = {
	    format = "{:%H:%M }";
	    interval = 60;
	    tooltip-format = "<tt>{calendar}</tt>";
	    timezone = "America/Sao_Paulo";

            calendar = {
	      format = {
                today = "<span color='#fAfBfC'><b>{}</b></span>";
	      };
	    };
	    actions = {
              on-click-right = "shift_down";
	      on-click = "shift_up";
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

    kitty = {
      enable = true;
    };

    neovim = {
      enable = true; 
    };
  };
}
