# 7 Days to Die Dedicated Server Setup
Setup for a 7 Days to Die dedicated server on an Amazon EC2 instance.

---

# Hardware Requirements
From personal testing and their writeup on the [Steam store](https://store.steampowered.com/app/251570/7_Days_to_Die/), the server hardware should have at least 2 vCPU and 8GB RAM with at least 20GB of storage.

In the future, I'll create a CloudFormation template and add it to this repository.

## AWS Sizes
- Basic server (vanilla configuration)
    - m5a.large (2x8)
- Advanced server (more enemies, larger map, more players)
    - c5a.xlarge (4x8)
    - m5a.xlarge (4x16)

The above options typically run cheap at about $0.10/hr on-demand. If you plan on running a server 24/7, it is highly recommended to set up a [reserved instance](https://aws.amazon.com/ec2/pricing/reserved-instances/) to save on costs.
  
## Storage
For a single EC2 server, you should only need a 32GB root volume. This should provide adequate space the installation (~15GB) and the saved world (~200MB+).

## Network Security
To protect your server, it is recommended to set the following network security inbound rules:
- SSH
    - `TCP 22`: your home public IP address (remove after setup if possible)
- Steam/Game Ports
    - `TCP 26900`: `::/0`
    - `TCP 26900`: `0.0.0.0/0`
    - `UDP 26900-26902`: `::/0`
    - `UDP 26900-26902`: `0.0.0.0/0`

Additionally, you can set the `ServerVisibility` to `0|1` (unlisted/friends only) to further secure access.

---

# Setup Instructions
After deploying your new EC2 instance, follow the below instructions to configure the dedicated server:.

1. As root, run `bootstrap.sh`
2. Once complete, switch to the steam user `su -l steam` and navigate to the steamcmd directory `cd ~/steamcmd`
3. Run steamcmd `./steamcmd`  
    a. Login with your Steam credentials `login STEAM_USERNAME STEAM_PASSWORD`  
    b. Enter your steamguard code if prompted  
    c. Exit the script `exit`  
4. To install the dedicated server, run `/opt/games/bin/update_7days.sh STEAM_USERNAME STEAM_PASSWORD`  
    a. As of Alpha 20, the server download is over 13GB. This may take 10+ minutes to download and verify  

After these steps, you can begin modifying of your server configuration

## Server Configuration
Before any modification, it is highly recommended to take a backup of your serverconfig.xml:
`cp /opt/games/7days/serverconfig.xml /opt/games/7days/serverconfig.xml.bak`

This repository includes an example serverconfig.xml which is current as of Alpha 20. Please reference the file along with any online documentation to further tailor your server experience.

Once satisfied with your changes, you can run the server with the `/opt/games/startserver.sh` script.

## Automation
If you would like to have your server run on startup:
1. Switch to the `steam` user `su -l steam`
2. Create a new crontab `crontab -e`  
    a. If using vim, press `i` to enter Insert mode  
    b. Add `@reboot /opt/games/startserver.sh`  
    c. Press `Escape` to stop editing  
    d. Enter `:wq` to save and exit  

Upon exiting, the crontab will be installed and run at the next reboot.

If you want to remove the crontab, simply follow the above steps and remove the entire `@reboot ...` line.

# Troubleshooting
Server logs are saved under `/opt/games/7days/7DaysToDieServer_Data/output_log*.txt`

Watch running logs:  
`tail -f /opt/games/7days/7DaysToDieServer_Data/output_log*.txt`

---

&nbsp;
