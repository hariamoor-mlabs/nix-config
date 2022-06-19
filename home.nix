{ config, pkgs, ... }: {
  nixpkgs.config = {
    allowUnfree = true;
    chromium = { enableWideVine = true; };
  };

  home = {
    username = "hariamoor";
    homeDirectory = "/home/hariamoor";
    packages = with pkgs; [
      bitwarden
      bitwarden-cli
      cachix
      cargo
      clang
      clippy
      direnv
      dmenu
      element-desktop
      flameshot
      gh
      niv
      helix
      llvm
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
      extensions = [ "aghfnjkcakhmadgdomlmlhhaocbkloab" ];
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

    fish = {
      enable = true;
      plugins = with pkgs; [
        {
          name = "hydro";
          src = fishPlugins.hydro.src;
        }
        {
          name = "pisces";
          src = fishPlugins.pisces.src;
        }
      ];
      shellInit = "set -gx EDITOR hx";
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
        keys = { insert = { j.k = "normal_mode"; }; };
      };
    };

    xmobar = {
      enable = true;
      extraConfig = builtins.readFile ./xmonad/xmobar.conf;
    };
  };

  services.lorri.enable = true;
}
