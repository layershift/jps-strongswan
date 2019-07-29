the OpenSource IPsec-based VPN Solution

In order to complete the setup you need the following information:
```
Peer public IP (right)       : The public IP of the VPN peer.
                               1.1.1.1
Peer sunbnet (rightsubnet)   : Subnet or IP address that will be reachable via the VPN. 
                               192.168.10.3/32
                               Multiple subnets can be set
                               192.168.10.0/24,192.168.20.3/32      
PSK                          : Pre shared key. It needs to be the same on both ends of the VPN
keyexchange                  : ikev2 or ikev1
---
Ciphers
ike                          : aes128-sha256-modp3072 (default) (editable)
esp                          : aes128-sha256 (default) (editable)
```
