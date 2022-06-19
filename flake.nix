{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  description = "Root Nix flake";

  outputs = attrs@{ self, nixpkgs, home-manager, fenix }: 
  let
    DEFAULT_MODULES = [
      ./configuration.nix
      ./hardware-configuration.nix
      home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users.hariamoor = import ./home.nix;
        };
      }
    ];
    system = "x86_64-linux";
    specialArgs = attrs;
  in {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        inherit system specialArgs;
        modules = DEFAULT_MODULES ++ [ ./wireguard.nix ];
      };
      laptop = nixpkgs.lib.nixosSystem {
        inherit system specialArgs;
        modules = DEFAULT_MODULES;
      };
    };
  };
}
