# Debian 使用笔记

## 安装、维护与升级

### [Download media](https://www.debian.org/distrib/netinst) from [mirrors](https://www.debian.org/CD/http-ftp/#mirrors) and [write image to USB](https://www.debian.org/CD/faq/#write-usb)
```bash
wget http://mirrors.163.com/debian-cd/current/amd64/iso-cd/debian-9.3.0-amd64-netinst.iso
wget http://mirrors.163.com/debian-cd/current/amd64/iso-cd/SHA1SUMS
shasum -c SHA1SUMS
sudo dd if=debian-9.3.0-amd64-netinst.iso of=/dev/da0 bs=4M; sync
```

### Packages Management
```bash
apt install debfoster
debfoster -q

debfoster sudo vim tmux rsync

# Basic Configurations:
# ~/.profile
# ~/.bashrc
# ~/.bash_aliases
# ~/.inputrc
# ~/.vimrc
# ~/.tmux.conf
# ~/.screenrc
```

### System Tools
```bash
sudo debfoster net-tools locales man-db resolvconf
```

### System-Wide Configuration
```bash
# locale
sudo vi /etc/default/locale     # add: LC_CTYPE=zh_CN.UTF-8
sudo dpkg-reconfigure locales   # choose: en_US.UTF-8(default), zh_CN.UTF-8

# users management
sudo addgroup group
sudo adduser -gid xxx user

# update & upgrade
sudo apt update && sudo apt upgrade

# hostname & FQDN
# sudo hostname <your_hostname>
sudo vim /etc/hostname
sudo vim /etc/hosts
```

### Pubkey Authentication
```bash
# run ssh-keygen on remote_host :
ssh-keygen -t rsa -b 4096 -C "$(whoami)@$(hostname)-$(date -I)"

# on ssh server, check /etc/ssh/sshd_config :
grep -E "^#?(PubkeyAuthentication|AuthorizedKeysFile|PasswordAuthentication|ChallengeResponseAuthentication)" /etc/ssh/sshd_config

# then edit :
# PubkeyAuthentication            yes
# AuthorizedKeysFile              .ssh/authorized_keys .ssh/authorized_keys2
# PasswordAuthentication          no
# ChallengeResponseAuthentication no

# and restart sshd :
sudo systemctl restart sshd.service
# or
sudo service ssh restart

# add pubkey to authorized_keys :
# ssh remote_user@remote_host cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
ssh-copy-id remote_user@remote_host
```

### Configure Wi-Fi on Debian
```bash
# https://wiki.debian.org/WiFi/
# https://blog.csdn.net/qq_41890503/article/details/89929496
# https://blog.csdn.net/tirecoed/article/details/6147250

sudo debfoster iw wireless-tools
sudo debfoster wpasupplicant

# Intel(R) Dual Band Wireless AC 8265
# https://wiki.debian.org/iwlwifi
# https://unix.stackexchange.com/questions/348748/how-to-configure-wi-fi-on-debian-9-stretch-with-network-card-intel-corporation-w
# add a "non-free" component to /etc/apt/sources.list
sudo debfoster firmware-iwlwifi

sudo iw interface_name scan | grep SSID
wpa_passphrase my_ssid my_passphrase

# iPhone Personal Hotspot
# https://my.oschina.net/u/260165/blog/1595629
sudo debfoster ipheth-utils

# https://vitux.com/how-to-start-stop-and-restart-services-in-debian-10/
sudo systemctl restart networking
sudo systemctl restart resolvconf
```

### Immigrate Debian
```bash
rsync -avzP --delete -e ssh --exclude=/.ssh/ --exclude=/.local/bin/ --exclude=/.local/include/ --exclude=/.local/lib/ --exclude=/.local/share/ --include=/.local/share/fonts/ src_path dest_path
```

### Install Debian 9 on Dell Precision T7810
```bash
# 0. Setup BIOS:
#    * Boot Mode: UEFI
#    * Secure Boot: Off

# 1. Install Debian 9 on Dell Precision T7810

# 2. Re-enter Rescure Mode, and run
mount -t vfat /dev/sda1 /mnt
mkdir -p /mnt/EFI/BOOT
cp /mnt/EFI/debian/grubx64.efi /mnt/EFI/BOOT/BOOTX64.EFI

# 3. Reboot

# A. References
#    1.  https://askubuntu.com/questions/657477/installaton-of-ubuntu-14-04-on-dell-precision-t7810-fails-no-boot-device-found
```

### Upgrade Debian 9 to 10
```bash
sudo apt update && sudo apt upgrade -y
sudo cp /var/lib/debfoster/keepers /var/lib/debfoster/keepers.bak
sudo debfoster -n

sudo apt update && sudo apt upgrade -y
lsb_release -a && cat /etc/*-release

sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
sudo sed -i 's/stretch/buster/g' /etc/apt/sources.list
sudo sed -i 's/stretch/buster/g' /etc/apt/sources.list.d/*.list

sudo apt update
sudo apt update && sudo apt upgrade -y
sudo apt dist-upgrade -y
sudo reboot

# reinstall packages ...
```

### Sound System
```bash
# https://blog.csdn.net/pingis58/article/details/120150700

# Lower Level
sudo debfoster alsa-utils
alsactl init

# list devices
aplay -L
aplay -l

# test
speaker-test -D default -c 2
speaker-test -D hw:1,0 -c 2
speaker-test -D hw:0,7 -c 2

# Higher Level
sudo debfoster pulseaudio
pacmd list sinks
pacmd set-default-sink 0

# Adjust Volume
alsamixer
amixer -q set Master 10%+
amixer -q set Master 10%+ unmute
amixer -q set Master 10%-
amixer -q set Master 10%- mute
amixer -q set Master 0%+ toggle
# or
pacmd set-sink-volume NAME|#N VOLUME
```

## 桌面环境
### xorg
```bash
sudo debfoster xorg fontconfig
sudo debfoster openbox tint2
sudo debfoster obconf obmenu lxappearance
sudo debfoster ibus-libpinyin
sudo debfoster geany xfe mupdf okular firefox-esr
sudo debfoster gcolor2 gpick
```

### Enable/disable synaptics touchpad in Debian 9
```bash
# https://unix.stackexchange.com/questions/388963/how-can-i-enable-disable-the-synaptics-touchpad-in-debian-9-with-libinput
sudo debfoster xinput

xinput list

# T470p
xinput set-prop "SynPS/2 Synaptics TouchPad" "Device Enabled" 0     # Disable
xinput set-prop "SynPS/2 Synaptics TouchPad" "Device Enabled" 1     # Enable

# TOSHIBA
xinput set-prop "SynPS/2 Synaptics TouchPad" "Device Enabled" 0

# Dell E5440
xinput set-prop "AlpsPS/2 ALPS GlidePoint" "Device Enabled" 0
```

### X Screen Locker
```bash
sudo debfoster xtrlock
xtrlock -f && top
```

### Linux on aliyun VPS
```bash
# http://server.it168.com/a2018/0612/3208/000003208560.shtml

# aliyun 控制台 :
# 安全组 -> 配置规则 -> 入方向 -> Port 10022

# on ssh server :
# /etc/ssh/sshd_config :
# PubkeyAuthentication            yes
# PasswordAuthentication          no
# ChallengeResponseAuthentication no
# GatewayPorts                    clientspecified

# on ssh client :
sudo debfoster autossh

sudo addgroup autossh
sudo adduser -gid xxx autossh
sudo chsh -s /usr/sbin/nologin autossh

# /etc/rc.local
su autossh -c '/usr/bin/autossh -M 0 -N -o "PubkeyAuthentication=yes" -o "StrictHostKeyChecking=false" -o "PasswordAuthentication=no" -o "ServerAliveInterval 60" -o "ServerAliveCountMax 3" -R 0.0.0.0:10022:localhost:22 autossh@ecs_vps'
```

## 实用工具
### ntfs
```bash
sudo debfoster ntfs-3g
sudo mount -t ntfs-3g /dev/sdc1 /mnt
sudo umount /mnt
```

### Using USB flash drive
```bash
sudo debfoster dosfstools
sudo fdisk -l
sudo dd if=/dev/zero of=/dev/sdX bs=4k && sync
sudo fdisk /dev/sdX
# 1. Using command 'o' to create a new empty DOS partition table.
# 2. Using command 'n' to add a new partition.
# 3. Using command 'w' to write table to disk and exit.
sudo mkdosfs -F 32 -I /dev/sdX1
sudo eject /dev/sdX
# References
#   1. https://askubuntu.com/questions/22381/how-to-format-a-usb-flash-drive
#   2. https://www.garron.me/en/go2linux/format-usb-drive-fat32-file-system-ubuntu-linux.html

```

### Web Server
```bash
sudo debfoster apache2 apache2-doc

# lightweight webserver
sudo debfoster webfs
```

### Archivers for RAR
```bash
sudo debfoster unrar-free unar
```

### Utilities for GFW :-/
```bash
sudo debfoster supervisor shadowsocks-libev proxychains privoxy
```

### 截屏
```bash
sudo debfoster scrot
( cd /paht/to/save/screenshot ; scrot -c -d 5 -u; switch_to_desktop_with_Alt-Tab )

# Or, run: ~/bin/my_scrot.sh [times]
```

### Formatter & Highlighter
```bash
# See: file:///usr/share/doc/astyle/html/astyle.html
sudo debfoster astyle
astyle --style=bsd -s4 [ -r ] [ --dry-run | -n ] "./*.cpp"

# code to HTML
sudo debfoster source-highlight
source-highlight --data-dir ~/.source-highlight -d --tab=4 -i input_file -o output_file
sed -i -e 's/<body bgcolor="[^"]*">/<body bgcolor="#D4D0C8">/' -e 's/charset=iso-8859-1/charset=utf-8/' output_file

# XML Reformatter
sudo debfoster xmlindent xmlformat-perl

# Other syntax checkers and reformatters
sudo debfoster tidy csstidy perltidy clang-tidy
```

### Generate Prime Numbers
```bash
sudo debfoster primesieve
primesieve [START] STOP -p
```

### Document Preparing
```bash
sudo debfoster texlive-full pdftk

# Applies a PDF watermark to the background of a single input PDF:
pdftk in.pdf background back.pdf output out.pdf

# PDF to HTML:
sudo debfoster pdf2htmlex

# Other utilities:
sudo debfoster latexml dvipng mathtex mimetex latex2html bibtex2html
```

### Video Player
```bash
sudo debfoster dragonplayer
dragon [URL] &
```

### Screen Recorder
```bash
sudo debfoster simplescreenrecorder
simplescreenrecorder &
```

### Office Productivity Suite
```bash
sudo debfoster libreoffice inkscape gimp
```

### Install Adobe Acrobat Reader in Debian
```bash
​# https://unix.stackexchange.com/questions/3505/how-to-install-adobe-acrobat-reader-in-debian

dpkg --print-architecture
dpkg --print-foreign-architectures
sudo dpkg --add-architecture i386
sudo apt-get update

sudo debfoster libgtk2.0-0:i386
sudo apt --fix-broken install
sudo debfoster libxml2:i386

# Alternatively, use gdebi to automatically resolve the dependencies:
sudo debfoster gdebi
sudo gdebi xxx

sudo dpkg -i AdbeRdr9.5.5-1_i386linux_enu.deb
```

### Hardware Info
```bash
​# http://os.51cto.com/art/201908/600787.htm

sudo debfoster lshw lshw-gtk hardinfo sysinfo
```

### Image Viewer
```bash
sudo debfoster gpicview lximage-qt qt5-image-formats-plugins
```

### System Monitor
```bash
sudo debfoster htop glances
```

## 开发工具
### Qt Creator
```bash
# See http://wiki.qt.io/Install_Qt_5_on_Ubuntu
sudo debfoster build-essential
sudo debfoster mesa-common-dev libgl1-mesa-dev
sudo debfoster gdb clang cmake git

cd ~/Downloads
wget http://download.qt.io/official_releases/online_installers/qt-unified-linux-x64-online.run
chmod +x qt-unified-linux-x64-online.run
./qt-unified-linux-x64-online.run

# or through apt:
# https://stackoverflow.com/questions/48147356/install-qt-on-ubuntu
sudo debfoster qt5-default libqt5serialport5-dev qtcreator
```

### SQLite3
```bash
sudo debfoster sqlite3 libsqlite3-dev
```

### Java Environment
```bash
sudo debfoster jflex cup

# debian 9:
#sudo debfoster eclipse-jdt

# debian 10:
sudo debfoster openjdk-11-jdk openjdk-11-source openjdk-11-doc

# Download Eclipse Installer from:
# https://www.eclipse.org/downloads/packages/installer
```

### PostgreSQL on Debian
```bash
sudo debfoster postgresql
sudo debfoster libpq5 libpq-dev
sudo debfoster libpqtypes0 libpqtypes-dev

# PostgreSQL Connection Settings:
#   https://www.postgresql.org/docs/9.1/static/runtime-config-connection.html
#   * listen_addresses
#   * port
#   * max_connections

# /etc/postgresql/9.6/main/postgresql.conf:
listen_addresses = '*'

# PostgreSQL 的用户验证和权限：

# Host-Based Authentication
#   https://www.postgresql.org/docs/10/static/auth-pg-hba-conf.html

# /etc/postgresql/9.6/main/pg_hba.conf:
#   The first record with a matching connection type, client address, requested database, and user name is used to perform authentication.
#   There is no “fall-through” or “backup”:
#   if one record is chosen and the authentication fails, subsequent records are not considered.
#   If no record matches, access is denied.
#   即：匹配上一条 [Connection Type] [Database] [User] 记录之后，如果验证通过则授权，否则则为授权被拒绝。

# TYPE  DATABASE        USER            ADDRESS                 METHOD

# "local" is for Unix domain socket connections only
local   all             all                                     md5
# IPv4 local connections:
host    all             all             192.168.0.0/24          md5

sudo systemctl status postgresql.service
sudo systemctl restart postgresql.service

# sudo passwd postgres
# OR:
# sudo -u postgres psql postgres

psql [-h ip_addr] -U xxx_user -d xxx_db
```

### Prolog Programming
```bash
sudo debfoster swi-prolog-nox
```

### VNC
```bash
# https://www.cnblogs.com/lidabo/p/3972512.html

sudo debfoster tightvncserver xtightvncviewer

# Setting up xtightvncviewer (1:1.3.9-9+deb10u1) ...
# update-alternatives: using /usr/bin/xtightvncviewer to provide /usr/bin/vncviewer (vncviewer) in auto mode

# Setting up tightvncserver (1:1.3.9-9+deb10u1) ...
# update-alternatives: using /usr/bin/tightvncserver to provide /usr/bin/vncserver (vncserver) in auto mode
# update-alternatives: using /usr/bin/Xtightvnc to provide /usr/bin/Xvnc (Xvnc) in auto mode
# update-alternatives: using /usr/bin/tightvncpasswd to provide /usr/bin/vncpasswd (vncpasswd) in auto mode

# On server:
mv ~/.vnc/xstartup xstartup.sample
cp ~/.xinitrc ~/.vnc/xstartup

vncserver -depth 24 -geometry 1680x1050
vncserver -kill :1

# On client:
vncviewer &
```

### JSON Libraries and Utilities
```bash
sudo debfoster libfastjson-dev libjson-c-dev libjsoncpp-dev nlohmann-json3-dev
sudo debfoster jq jshon
```
