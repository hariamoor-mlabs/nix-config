{ config, pkgs, fenix, ... }: {
  nixpkgs.config = {
    allowUnfree = true;
    chromium = {
      enableWideVine = true;
    };
    overlays = [ fenix.overlay ];
  };

  home = {
    username = "hariamoor";
    homeDirectory = "/home/hariamoor";
    packages = with pkgs; [
      bitwarden
      bitwarden-cli
      cachix
      direnv
      dmenu
      element-desktop
      (fenix.complete.withComponents [
        "cargo"
	"clippy"
	"rustc"
	"rustfmt"
	"rust-src"
      ])
      flameshot
      gh
      helix
      niv
      nix-prefetch-github
      onlykey
      onlykey-agent
      piper
      ripgrep-all
      rust-analyzer-nightly
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
  
    xmobar = {
      enable = true;
      extraConfig = builtins.readFile ./xmonad/xmobar.conf;
    };
  };

  services = {
    lorri.enable = true;
    ratbagd.enable = true;
    trezord.enable = true;
    redshift = {
      enable = true;
      temperature = {
        day = 2500;
        night = 1000;
      };
    };
  };
} 
