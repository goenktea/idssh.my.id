# /bin/bash
cd
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
exit 0
END
chmod +x /etc/rc.local
systemctl enable rc-local
systemctl start rc-local.service
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local
##configurasi v2ray
cd /usr/local/etc/xray
wget -O v2ray.crt https://raw.githubusercontent.com/goenktea/idssh.my.id/main/cert.crt && mv v2ray.crt /usr/local/etc/xray
wget -O v2ray.key https://raw.githubusercontent.com/goenktea/idssh.my.id/main/key.key && mv v2ray.key /usr/local/etc/xray
##trojan
cd
cd /usr/local/etc/trojan
rm config.json
wget https://github.com/goenktea/idssh.my.id/raw/main/tr.zip && unzip tr.zip
rm tr.zip
wget https://www.dropbox.com/s/q8hljwluf1c1929/exptrojan && chmod +x exptrojan && mv exptrojan /usr/bin
cd /etc
mv crontab crontab.bak
wget https://github.com/goenktea/idssh.my.id/raw/main/crontab.zip && unzip crontab.zip
rm crontab.zip
systemctl enable trojan
systemctl start trojan
systemctl restart trojan
reboot

