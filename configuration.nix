{ config, pkgs, ... }: {
  boot.loader.systemd-boot.enable = true;

  fonts = {
    fonts = with pkgs; [ nerdfonts ];
    fontconfig.enable = true;
  };
 
  networking = {
    firewall.allowedUDPPorts = [ 51820 ];
    networkmanager.enable = true;
    wg-quick.interfaces.wg0 = {
      address = [ "10.2.0.2/32" ];
      dns = [ "10.2.0.1" ];
      privateKeyFile = "/etc/privkeys/wireguard.txt";
 
      peers = [
        { publicKey = "kiVlibDLh5yZQOJ6Gaw1MB9wt4YHmKpfXZrAc0No9Gc=";
	  allowedIPs = [ "0.0.0.0/0" ];
	  endpoint = "69.10.63.242:51820"; 
	}
      ];
    };
  };
 
  nix = {
    binaryCaches = [
      "https://hydra.iohk.io/"
      "https://iohk.cachix.org/"
      "https://mlabs.cachix.org/"
    ];
    binaryCachePublicKeys =
    let
      mlabs-cachix = "/etc/privkeys/mlabs-cachix.txt";
    in [
      "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
      "iohk.cachix.org-1:DpRUyj7h7V830dp/i6Nti+NEO2/nhblbov/8MW7Rqoo="
      "mlabs.cachix.org-1:${builtins.readFile mlabs-cachix}"
    ];
    trustedUsers = [ "hariamoor" ];
    extraOptions = "experimental-features = nix-command";
    package = pkgs.nixUnstable;
    maxJobs = "auto";
    autoOptimiseStore = true;
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
    ratbagd.enable = true;
    trezord.enable = true;
    xserver = {
      enable = true;
      windowManager.xmonad = {
        enable = true;
	config = builtins.readFile "/etc/nixos/xmonad/xmonad.hs";
	extraPackages = hp: [
	  hp.xmonad-contrib
	  hp.monad-logger
	];
      };
      videoDrivers = [ "nvidia" ];
      xkbOptions = "caps:escape";
    };
    redshift = {
      enable = true;
      temperature = {
        day = 2500;
        night = 1000;
      };
    };
  };
 
  virtualisation.docker.enable = true;
 
  users.users.hariamoor = {
    home = "/home/hariamoor";
    description = "Main user account";
    extraGroups = [ "docker" "wheel" "networkmanager" ];
    isNormalUser = true;
    shell = pkgs.fish;
  };
 
  environment = {
    systemPackages = with pkgs; [
      alacritty
      vimHugeX
      nftables
      curl
      feh
      imagemagick
      cachix
    ];
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
    stateVersion = "22.11";
  };
}
