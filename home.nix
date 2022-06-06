{config, pkgs, ... }: {
  imports = [ ./programs.nix ];

  nixpkgs.config.allowUnfree = true;

  home = {
    stateVersion = "22.05";
    username = "hariamoor";
    homeDirectory = "/home/hariamoor";
    packages = with pkgs; [
      bitwarden
      bitwarden-cli
      cargo
      dmenu
      element-desktop
      flameshot
      gh
      niv
      nix-prefetch-github
      onlykey
      onlykey-agent
      piper
      ripgrep
      ripgrep-all
      rnix-lsp
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
} 
