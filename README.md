# Debian 使用笔记

## 安装 Debian Base

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
# ~/.bash_aliases
# ~/.inputrc
# ~/.bashrc
# ~/.tmux.conf
# ~/.vimrc
# ~/.screenrc

```

### System Tools
```bash
sudo debfoster net-tools locales man-db
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
```

## 安装 Packages
### xorg
```bash
sudo debfoster xorg fontconfig
sudo debfoster openbox tint2
sudo debfoster obconf obmenu lxappearance gcolor2
sudo debfoster ibus-libpinyin
sudo debfoster geany xfe mupdf firefox-esr
```

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
```

### CAN Utilities
```bash
sudo debfoster build-essential
sudo debfoster libusb-1.0-0
sudo debfoster libeigen3-dev
```

## Others
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

### X Screen Locker
```bash
sudo debfoster xtrlock
xtrlock -f && top
```

### Immigrate Debian
```bash
sudo debfoster xorg fontconfig openbox tint2 obconf obmenu lxappearance ibus-libpinyin geany xfe mupdf firefox-esr

# Restore files/dirs :
# ~/.config
# ~/.gitconfig
# ~/.gtkrc-2.0
# ~/.gtkrc-2.0.mine
# ~/.local/share
# ~/.mozilla
# ~/.xinitrc
# ~/.Xresources.d
# ~/.Xresources
ssh srv_host tar -C ~ -zcvf - .config .gitconfig .gtkrc-2.0 .gtkrc-2.0.mine .local .mozilla .xinitrc .Xresources.d .Xresources | ( cd ~ ; tar -zxvf - )
```

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

### SQLite3
```bash
sudo debfoster sqlite3 libsqlite3-dev
```

### Lightweight Webserver
```bash
sudo debfoster webfs
```

### Java Environment
```bash
sudo debfoster jflex cup eclipse-jdt
```

### Archivers for RAR
```bash
sudo debfoster unrar-free unar
```

### Utilities for GFW :-/
```bash
sudo debfoster shadowsocks-libev supervisor proxychains
```

### Pubkey Authentication
```bash
# run ssh-keygen on remote_host :
ssh-keygen -t rsa -b 4096 -C "$(whoami)@$(hostname)-$(date -I)"

# on ssh server, edit /etc/sshd.conf :
# PubkeyAuthentication            yes
# AuthorizedKeysFile              .ssh/authorized_keys .ssh/authorized_keys2
# PasswordAuthentication          no
# ChallengeResponseAuthentication no

# and restart sshd :
sudo systemctl restart sshd.service
# or
sudo service ssh restart

# add pubkey to authorized_keys :
ssh remote_host cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
```

### PostgreSQL on Debian
```bash
sudo debfoster postgresql
sudo debfoster libpq5 libpq-dev
sudo debfoster libpqtypes0 libpqtypes-dev

sudo passwd postgres
sudo systemctl status postgresql.service
sudo systemctl restart postgresql.service

psql [-h ip_addr] -U xxx_user -d xxx_db

# PostgreSQL Connection Settings:
#   https://www.postgresql.org/docs/9.1/static/runtime-config-connection.html
#   * listen_addresses
#   * port
#   * max_connections

# PostgreSQL 的用户验证和权限：

# Host-Based Authentication
#   https://www.postgresql.org/docs/10/static/auth-pg-hba-conf.html

# /etc/postgresql/9.6/main/pg_hba.conf:
#   The first record with a matching connection type, client address, requested database, and user name is used to perform authentication.
#   There is no “fall-through” or “backup”:
#   if one record is chosen and the authentication fails, subsequent records are not considered.
#   If no record matches, access is denied.
#   即：匹配上一条 [Connection Type] [Database] [User] 记录之后，如果验证通过则授权，否则则为授权被拒绝。
```

### 截屏
```bash
sudo debfoster scrot
( cd /paht/to/save/screenshot ; scrot -c -d 5 ; switch_to_desktop_with_Alt-Tab )
```

### 串口
```bash
sudo debfoster microcom minicom
microcom -s 115200 -p /dev/ttyUSB0
minicom -s
minicom -c on
```

### 3D Graphics
```bash
# OpenGL:
sudo debfoster libglm-dev libglew-dev libglfw3-dev freeglut3-dev libassimp-dev

# OpenSceneGraph:
sudo debfoster openscenegraph-3.4 libopenscenegraph-3.4-dev openscenegraph-3.4-doc openscenegraph-3.4-examples

# OGRE:
sudo debfoster libogre-1.9-dev ogre-1.9-tools blender-ogrexml-1.9 libois-dev
```

### Source Code Formatter
```bash
# See: file:///usr/share/doc/astyle/html/astyle.html
sudo debfoster astyle
astyle --style=bsd -s4 [ --dry-run | -n ] [ -r ] ./*.{c,h}
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
```

### Prolog Programming
```bash
sudo debfoster swi-prolog-nox
```
