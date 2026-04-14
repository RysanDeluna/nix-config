{ pkgs, ... }:
{
  home.packages = [
    pkgs.hyprpicker
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    systemd.variables = [ "--all" ];
    settings = {
      general = {
        border_size = 2;
        gaps_in = 1;
        gaps_out = 4;

        float_gaps = 4;

        "col.active_border" = "rgb(D8DEE9)";
        "col.inactive_border" = "rgb(2e3440)";

        resize_on_border = false;
        layout = "dwindle";
      };

      decoration = {
        rounding = 0;
        active_opacity = 1.0;
        inactive_opacity = 0.98;
        shadow = {
          enabled = false;
        };
        blur = {
          enabled = false;
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
          # Name	  # on  # speed # curve         # etc
          "global,      1,      10,     default"
          "border,      1,    5.39,     easeOutQuint"
          "windows,     1,    4.79,     easeOutQuint"
          "windowsIn,   1,     4.1,     easeOutQuint, popin 87%"
          "windowsOut,  1,    1.49,     linear,       popin 87%"
          "fadeIn,      1,    1.73,     almostLinear"
          "fadeOut,     1,    1.46,     almostLinear"
          "fade,        1,    3.03,     quick"
          "layers,      1,    3.81,     easeOutQuint"
          "layersIn,    1,       4,     easeOutQuint, fade"
          "layersOut,   1,     1.5,     linear,       fade"
          "fadeLayersIn,1,    1.79,     almostLinear"
          "fadeLayersOut,1,   1.39,     almostLinear"
          "workspaces,  1,      2,     quick"
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
      "$launch_with_class" = "foot -a";
      "$fileManager" = "nautilus --new-window";
      "$menu" = "wofi --show";
      "$mod" = "SUPER";
      "$scripts_dir" = "$HOME/.dotfiles/scripts";

      exec-once = [
        "udiskie"
        "waypaper --restore"
        "waybar"
        "mako"
        "nm-applet --indicator"
        "clipse -listen"
      ];

      monitor = "eDP-1,1920x1080@120,0x0,1.2";
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
        touchpad = {
          natural_scroll = true;
        };
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

      binded = [
        "$mod CTRL, j,  resize d, resizeactive, 0 40"
        "$mod CTRL, k,  resize u, resizeactive, 0 -40"
        "$mod CTRL, h,  resize l, resizeactive, -40 0"
        "$mod CTRL, l,  resize r, resizeactive, 40 0"

        "ALT, TAB, Cycle windows, cyclenext, "
      ];
      bindd = [
        # MODs, KEY,    DESCR   DISPATCHER, params
        "$mod,  W,      Close active, killactive"
        "$mod,  Q,      Exit,         exit"
        "$mod,  RETURN, Terminal,     exec,$terminal"
        "$mod,  O,      dmenu,        exec,$menu drun"
        "$mod,  P,      scripts dmenu,exec,$scripts_dir/999_dmenu_script.sh $scripts_dir/"
        "$mod,  V,      Clipboard history,  exec, $launch_with_class clipse -e 'clipse'"
        "$mod,  F1,     HELP,         exec, $launch_with_class help_window -e 'kbhelper.sh'"

        "$mod,  T,      Floating,   togglefloating,"
        "$mod,  KP_Add, Fullscreen, fullscreen,1"
        "$mod,  F11,    Ultra FS,   fullscreen,0"

        "$mod,  j,      go down,    movefocus,d"
        "$mod,  k,      go up,      movefocus,u"
        "$mod,  h,      go left,    movefocus,l"
        "$mod,  l,      go right,   movefocus,r"

        "$mod SHIFT,  j,  move d, movewindow,d"
        "$mod SHIFT,  k,  move u, movewindow,u"
        "$mod SHIFT,  h,  move l, movewindow,l"
        "$mod SHIFT,  l,  move r, movewindow,r"

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

        "$mod,TAB,Next Workspace,workspace,previous"
      ];

      windowrule = [
        # Network manager
        "float, class:nm-connection-editor"
        "move 100%-w-20 5% , class:nm-connection-editor"

        # Pwvucontrol
        "float, class:com.saivert.pwvucontrol"
        "size 1079 350, class:com.saivert.pwvucontrol"
        "move 514 39, class:com.saivert.pwvucontrol"

        # Clipse
        "float, class:clipse"
        "size 70% 70%, class:clipse"

        # Help Keyboard
        "float, class:help_window"
        "size 70% 70%, class:help_window"
      ];
    };
  };
}
