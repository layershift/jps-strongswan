Success!
Your strongswan is ready!

Information required by the VPN peer:
```
Our public IP : ${globals.targetNodeExtIp}
Our subnet    : ${globals.targetNodeIntIp}
PSK           : ${settings.psk}
keyexchange   : ${settings.keyexchange}
---
Ciphers
ike           : ${settings.ike}
esp           : ${settings.esp}
