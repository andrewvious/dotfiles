{ pkgs, inputs, ... }:

{
  home.username = "andrewvious";
  home.homeDirectory = "/home/andrewvious";

  home.packages = with pkgs; [
    home-manager
    wl-clipboard
    brave
    kitty
    # shell
    zsh
    oh-my-zsh
    neofetch
    # comms
    telegram-desktop
    # code
    docker
    git
    helix
    reaper
    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions; [
        bbenoist.nix # nix syntax highlighting
        rust-lang.rust-analyzer
        vadimcn.vscode-lldb # lldb for rust
        pkief.material-product-icons
        tamasfe.even-better-toml
        esbenp.prettier-vscode
        ms-vsliveshare.vsliveshare
        vscodevim.vim
        piousdeer.adwaita-theme
        dracula-theme.theme-dracula
        zhuangtongfa.material-theme
        file-icons.file-icons
        eamodio.gitlens # git lens
        ms-python.python
      ];
    })
    nil # nix lsp for Helix
    # studio
    obs-studio
    ffmpeg # video formatter
    v4l-utils
    gphoto2
    #    fix kernel header vvvvvvvvvv
    # linuxKernel.packages.linux_5_15.vrl2loopbacko
    gnomeExtensions.color-picker
    gnomeExtensions.pop-shell
    gnomeExtensions.system-monitor
    gnomeExtensions.user-themes
    tlp
    auto-cpufreq
    discord
    xdg-desktop-portal
    xdg-desktop-portal-gnome
    blender
    steam
    libreoffice
    kitty-themes
    vlc
  ] ++ [ (pkgs.callPackage ./tiup.nix {}) ];
  
  programs.kitty = {
    enable = true;
    theme = "kanagawabones";
    font.name = "JetBrainsMono Nerd Font";
    settings = {
      hide_window_decorations = true;
    };
  };

  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      theme = "kanabox_default";
      editor = {
        cursor-shape = {
          insert = "underline";
          normal = "block";
          select = "block";
        };
        statusline = {
          mode = {
            insert = "INSERT";
            normal = "NORMAL";
            select = "SELECT";
          };
        };
        indent-guides = {
          render = true;
          characeter = "|";
        };
        lsp = {
          display-messages = true;
          display-inlay-hints = true;
        };
      };
    };
    themes = inputs.helix-themes.outputs.themes;
  };

  # zsh & oh-my-zsh configurations
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion = {
        enable = true;
      };
      shellAliases = {
        swaydev = "nix develop github:fuellabs/fuel.nix#sway-dev -c zsh";
      };
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" ];
        theme = "dst";
      };
    };

    git = {
      enable = true;
      userName = "andrewvious";
      userEmail = "ohbandrew@gmail.com";
    };

    # Let Home Manager install and manage itself.
    home-manager.enable = true;
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Colloid-dark";
      package = pkgs.colloid-icon-theme;
    };
    theme = {
      name = "Nordic-darker";
      package = pkgs.nordic;
    };
    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };
  home.sessionVariables.GTK_THEME = "Nordic-darker";
  dconf.settings = {
    # shell extensions
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "pop-shell@system76.com"
        "user-theme@gnome-shell-extensions.gcampax.github.com"
      ];
    };
    "org/gnome/shell/extensions/user-theme" = {
      name = "Nordic-darker";
    };

    # keybindings
    "org/gnome/shell/keybindings" = {
      toggle-quick-settings = []; # turn off focus power menu
      toggle-message-tray = ["<Super>n"];
      focus-active-notification = [];
    };
    "org/gnome/desktop/wm/keybindings" = {
      close = ["<Super>q"];
      minimize = [];
      maximize = [];
      toggle-maximized = ["<Super>m"];
      # workspace/monitor settings
      switch-to-workspace-left = ["<Alt>h"];
      switch-to-workspace-right = ["<Alt>l"];
      move-to-workspace-left = ["<Shift><Alt>h"];
      move-to-workspace-right = ["<Shift><Alt>l"];
      move-to-monitor-down = [];  # handled by pop-shell
      move-to-monitor-left = [];  #
      move-to-monitor-right = []; #
      move-to-monitor-up = [];    #
    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      screensaver = []; # turn off lock screen
    };
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.
}

