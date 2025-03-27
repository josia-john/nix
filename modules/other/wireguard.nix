{ pkgs, ... }: {
  networking.wg-quick.interfaces = {
    wg0 = {
      address = [ "10.1.250.11/32" ];
      dns = [ "1.1.1.1" ];
      privateKeyFile = "/etc/wireguard/private";
      
      mtu = 1384;

      peers = [
        {
          publicKey = "GF1fSDK9rMmNmz7GoPiOufnRF+bm6FTwgRFKl4Xpo1E=";
          presharedKeyFile = "/etc/wireguard/SWUPP/preshared";
          allowedIPs = [ "10.8.0.0/16" ];
          endpoint = "81.221.87.45:51821";
          persistentKeepalive = 25;
        }
      ];
    };
    wg1 = {
      address = [ "10.71.0.2/32" ];
      dns = [ "10.15.0.2" "1.1.1.1" ];
      privateKeyFile = "/etc/wireguard/SWUPP-DEVOPS/private";
      
      mtu = 1384;

      listenPort = 51820;

      peers = [
        {
          publicKey = "jKboas20fYiBPaKEr8nMBsnUrTWAJgx2QEM6x2wjOEU=";
          presharedKeyFile = "/etc/wireguard/SWUPP-DEVOPS/preshared";
          allowedIPs = [ "10.71.0.0/16" "10.15.0.0/16" ];
          endpoint = "vpnserver.s2labs.ch:51820";
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
