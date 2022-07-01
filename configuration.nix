{ config, pkgs, ... }: {
  boot.loader.systemd-boot.enable = true;

  fonts = {
    fonts = with pkgs; [ nerdfonts ];
    fontconfig.enable = true;
  };

  nix = {
    binaryCaches = [ "https://hydra.iohk.io/" "https://iohk.cachix.org/" ];
    binaryCachePublicKeys = [
      "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
      "iohk.cachix.org-1:DpRUyj7h7V830dp/i6Nti+NEO2/nhblbov/8MW7Rqoo="
    ];
    trustedUsers = [ "hariamoor" ];
    package = pkgs.nixUnstable;
    maxJobs = "auto";
    autoOptimiseStore = true;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  nixpkgs.config.allowUnfree = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkbOptions in tty.
  };

  location.provider = "geoclue2";
  sound.enable = true;
  hardware = {
    pulseaudio.enable = true;
    opengl.enable = true;
    onlykey.enable = true;
  };

  services = {
    geoclue2.enable = true;
    ratbagd.enable = true;
    trezord.enable = true;
    redshift = {
      enable = true;
      temperature = {
        day = 1000;
        night = 1000;
      };
    };
    xserver = {
      enable = true;
      windowManager.xmonad = {
        enable = true;
        config = builtins.readFile ./xmonad/xmonad.hs;
        extraPackages = hp: [ hp.xmonad-contrib hp.monad-logger ];
      };
      videoDrivers = [ "nvidia" ];
      xkbOptions = "caps:escape";
    };
  };

  virtualisation.docker.enable = true;

  users = {
    users.hariamoor = {
      home = "/home/hariamoor";
      description = "Main user account";
      extraGroups = [ "docker" "wheel" "networkmanager" ];
      isNormalUser = true;
      shell = pkgs.fish;
      createHome = true;
      hashedPassword = "";
      initialPassword = "";
    };
    mutableUsers = false;
  };

  environment = {
    systemPackages = with pkgs; [ alacritty nftables curl feh imagemagick ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system = {
    autoUpgrade = {
      enable = true;
      allowReboot = true;
      channel = "https://nixos.org/channels/nixos-unstable-small";
    };
  };
}
