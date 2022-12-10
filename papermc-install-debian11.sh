#!/bin/bash

# papermc-install-debian11.sh
# Run on a fresh Debian 11.x server to install paper-1.19.2-307 Minecraft Server
# Execute this script with sudo as the user you intend to run the server .jar as:
# e.g. sudo ./papermc-install-debian11.sh

if [ `whoami` != root ]; then
    echo "Please run this script with sudo"
    exit
fi

USER=`who am i | awk '{print $1}'`
echo -e "\nScript being run as user ${USER}..."

echo -e '\nInstalling openjdk-17-jre...'
apt install openjdk-17-jre -y

echo -e '\nPreparing /opt/minecraft/papermc/...'
mkdir -p /opt/minecraft/papermc

echo -e '\nDownloading paper-1.19.2-307.jar...'
wget https://api.papermc.io/v2/projects/paper/versions/1.19.2/builds/307/downloads/paper-1.19.2-307.jar -O /opt/minecraft/papermc/paper-1.19.2-307.jar

echo -e '\nCreating /opt/minecraft/papermc/eula.txt...'
echo "eula=true" > /opt/minecraft/papermc/eula.txt

echo -e '\nCreating launch script /opt/minecraft/papermc-start-5g.sh...'
cat <<EOT > /opt/minecraft/papermc-start-5g.sh
#!/bin/bash
echo 'Launching paper-1.19.2-307.jar with 5G memory limit...'
cd /opt/minecraft/papermc/ ; java -Xms5G -Xmx5G -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -jar paper-1.19.2-307.jar nogui
EOT
chmod +x /opt/minecraft/papermc-start-5g.sh
echo -e "\nChanging ownership of /opt/minecraft and subdirectories to ${USER}:${USER}..."
chown -R $USER:$USER /opt/minecraft/

echo -e '\nDone. Run the following script to launch paper server:'
echo '/opt/minecraft/papermc-start-5g.sh'
