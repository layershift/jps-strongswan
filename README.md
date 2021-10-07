# Strongswan Add-on

This repository provides [Strongswan](https://www.strongswan.org/) add-on for Jelastic Platform.

**Strongswan** is an OpenSource IPsec-based VPN Solution

**Type of nodes this add-on can be applied to**: 
- Application server (cp).

### What it can be used for?
It will provide a secure connection from your VPN gateway to the 1st application server of your environment. Strongswan can be used to create  ikev1 or ikev2 tunnels.

### Deployment
In order to get this solution instantly deployed, click the "Deploy to Jelastic" button

[![GET IT HOSTED](https://raw.githubusercontent.com/jelastic-jps/jpswiki/master/images/getithosted.png)](https://app.j.layershift.co.uk/?manifest=../../raw/master/manifest.jps)

To deploy this package to Jelastic Private Cloud, import [this JPS manifest](../../raw/master/manifest.jps) within your dashboard ([detailed instruction](https://docs.jelastic.com/environment-export-import#import)).

For more information on what Jelastic add-on is and how to apply it, follow the [Jelastic Add-ons](https://github.com/jelastic-jps/jpswiki/wiki/Jelastic-Addons) reference.

### Installation Process

![Install](../../raw/master/images/strongswan_install_options.png)

* Peer public IP (right) : The public IP of the VPN peer.

* Peer subnet (rightsubnet) : Subnet or IP address that will be reachable via the VPN
Multiple remote subnets can be entered separated by , (192.168.10.0/24,192.168.20.3/32)

* PSK : Pre shared key. It needs to be the same on both ends of the VPN

* keyexchange : ikev2 or ikev1

Ciphers

* ike : aes128-sha256-modp3072 (default) (ediatable)

* esp : aes128-sha256 (default) (ediatable)

### Actions

![Options](../../raw/master/images/strongswan_options.png)
Once installed you can:

* Change the configuration parameters using Configure button
* Check tunnel status using Status button
* Restart Strongswan
* Rebuild the configuration without changing parameters

### CLI options:
```
sudo systemctl status strongswan
sudo systemctl stop strongswan
sudo systemctl start strongswan
sudo systemctl restart strongswan
ipsec statusall
ipsec down myVPN
ipsec up myVPN
```

### Additional checks

There is a cron task installed that will check the status of strongswan service and will restart it if it's stopped.

### Known issues

StrongSwan uses a tap interface. If you don't have the ipsec0 interface ask your hoster to enable tun/tap.