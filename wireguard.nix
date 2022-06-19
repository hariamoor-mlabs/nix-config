{ config, pkgs, ... }: {
  networking = {
    firewall.allowedUDPPorts = [ 51820 ];
    networkmanager.enable = true;
    wg-quick.interfaces.wg0 = {
      address = [ "10.2.0.2/32" ];
      dns = [ "10.2.0.1" ];
      privateKeyFile = "/etc/privkeys/wireguard.txt";
      peers = [{
        publicKey = "nG4IB7yIBmezw4rcpX3SK9UyjjuKjIZZhssCD26jlhM=";
        allowedIPs = [ "0.0.0.0/0" ];
        endpoint = "37.120.244.58:51820";
      }];
    };
  };
}
