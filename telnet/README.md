# Telnet
This section goes over functionality for using telnet to issue commands to the 7 Days to Die Dedicated Server.

---

# Requirements
For this to work, you need to verify your `serverconfig.xml` configuration. By default, telnet is enabled for localhost, as specified by the `Telnet*` properties:
```
<property name="TelnetEnabled" value="true"/> <!-- Enable/Disable the telnet -->
<property name="TelnetPort" value="8081"/> <!-- Port of the telnet server -->
<property name="TelnetPassword" value=""/> <!-- Password to gain entry to telnet interface. If no password is set the server will only listen on the local loopback interface -->
```

**Note: ensure you do not have the telnet port forwarded/publically facing the internet - your server can and will be compromised!**

When running a server on a cloud platform, you can lock down this traffic with a network security group.

# Scripts

# telnet.sh
This script is for running commands against a telnet endpoint. By default, this script is set to run against `localhost:8081`.

# 7dtd_update_date.sh
This script issues a date command (`gettime gt`) and outputs to a JSON file to upload to an API endpoint.

# 7dtd_update_player.sh
This script issues a date command (`listplayers lp`) and outputs to a JSON file to upload to an API endpoint.

---

&nbsp;
