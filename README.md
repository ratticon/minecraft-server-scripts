# minecraft-server-scripts
Scripts to make Minecraft server deployment faster and easier, but *not necessarily safer*   
Don't use for production / sensitive workloads. You break it, you fix it.

## [papermc-install-debian11.sh](https://github.com/ratticon/minecraft-server-scripts/blob/main/papermc-install-debian11.sh)
A lazy script to deploy [paper-1.19.2-307](https://papermc.io/downloads#Paper-1.19) server on a fresh [Debian 11.x (Bullseye)](https://www.debian.org/releases/bullseye/) install.   
Installs to `/opt/minecraft/papermc/` with a launcher script tuned for 5G memory at `/opt/minecraft/papermc-start-5g.sh`
```
wget https://raw.githubusercontent.com/ratticon/minecraft-server-scripts/main/papermc-install-debian11.sh && chmod +x papermc-install-debian11.sh && sudo ./papermc-install-debian11.sh
```
