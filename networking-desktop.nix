{ config, pkgs, ... }: {
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
}
