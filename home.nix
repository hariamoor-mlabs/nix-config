{ config, pkgs, ... }: {
  nixpkgs.config = {
    allowUnfree = true;
    chromium = {
      enableWideVine = true;
    };
  };

  home = {
    username = "hariamoor";
    homeDirectory = "/home/hariamoor";
    packages = with pkgs; [
      bitwarden
      bitwarden-cli
      cachix
      cargo
      clippy
      direnv
      dmenu
      element-desktop
      flameshot
      gh
      niv
      nix-prefetch-github
      onlykey
      onlykey-agent
      piper
      ripgrep-all
      rust-analyzer
      rustc
      rustfmt
      slack
      trezor-suite
      trezor_agent
      trezorctl
      xclip
      zoom-us
    ];
  };

  programs = {
    chromium = {
      enable = true;
      extensions = [
        "aghfnjkcakhmadgdomlmlhhaocbkloab"
      ];
    };

    git = {
      enable = true;
      userName = "hariamoor-mlabs";
      userEmail = "hari@mlabs.city";
    };
  
    htop = {
      enable = true;
      package = pkgs.htop-vim;
    };
  
    home-manager.enable = true;
    
    helix = {
      enable = true;
      settings = {
        theme = "onedark";
        editor = {
          lsp.display-messages = true;
          line-number = "relative";
        };
        keys = {
          insert = {
            j.k = "normal_mode";
          };
        };
      };
    };
  
    xmobar = {
      enable = true;
      extraConfig = builtins.readFile ./xmonad/xmobar.conf;
    };
  };

  services.lorri.enable = true;
} 
