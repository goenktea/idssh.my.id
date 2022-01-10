#/bin/bash
cd
##BANNER SSH
wget https://raw.githubusercontent.com/goenktea/installer/main/gtea && mv gtea /etc
wget -O /usr/bin/badvpn-udpgw "https://github.com/zahwanugrah/AutoScriptSSH/raw/main/badvpn-udpgw64"
chmod +x /usr/bin/badvpn-udpgw
local.service
cat > /etc/systemd/system/rc-local.service <<-END
[Unit]
Description=/etc/rc.local
ConditionPathExists=/etc/rc.local
[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99
[Install]
WantedBy=multi-user.target
END
cat > /etc/rc.local <<-END
#!/bin/sh -e
# rc.local
# By default this script does nothing.
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7000 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7400 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7500 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7600 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7700 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7800 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7900 --max-clients 500
screen -dmS proxy ./usr/bin/ws-ssh -l 80 -r 127.0.0.1:447
screen -dmS proxy ./usr/bin/ws-ssh -l 8880 -r 127.0.0.1:447
exit 0
END
chmod +x /etc/rc.local
systemctl enable rc-local
systemctl start rc-local.service
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local

##installer openvpn
cd /etc
mv openvpn ovpnori
mkdir openvpn
cd openvpn
wget https://github.com/goenktea/idssh.my.id/raw/main/ovpn.zip && unzip ovpn.zip
rm ovpn.zip
## ws ssh
cd
wget -O ws-ssh https://github.com/goenktea/x86_x64/blob/main/eProxy?raw=true && chmod 744 ws-ssh && mv ws-ssh /usr/bin
##install sslh
apt install sslh -y

cd /etc/default/
rm sslh
wget https://github.com/goenktea/idssh.my.id/raw/main/sslh.zip && unzip sslh.zip
rm sslh.zip
##configurasi stunnel4
cd /etc/stunnel
rm stunnel.conf
wget https://github.com/goenktea/idssh.my.id/raw/main/stunnel.zip && unzip stunnel.zip
rm stunnel.zip
## configurasi dropbeard
cd
apt-get install -y dropbear
cd /etc/default
rm dropbear
wget https://github.com/goenktea/idssh.my.id/raw/main/dropbear.zip && unzip dropbear.zip
rm dropbear.zip
## configurasi sshd
cd /etc/ssh
rm sshd_config
wget https://github.com/goenktea/idssh.my.id/raw/main/sshd_config.zip && unzip sshd_config.zip
rm sshd_config.zip
reboot

