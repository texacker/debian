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
sudo apt-get install debfoster
sudo debfoster -q
```

### System Tools
```bash
sudo debfoster net-tools locale man-db
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
sudo apt-get update && sudo apt-get upgrade
```

## 安装 Packages
### xorg
```bash
sudo debfoster xorg fontconfig
sudo debfoster openbox tint2 obconf obmenu lxappearance
sudo debfoster ibus-libpinyin
sudo debfoster geany xfe mupdf firefox-esr
```

### Qt Creator
```bash
# See http://wiki.qt.io/Install_Qt_5_on_Ubuntu
sudo debfoster build-essential
sudo debfoster libgl1-mesa-dev
sudo debfoster gdb git clang

cd ~/Downloads
wget http://download.qt.io/official_releases/online_installers/qt-unified-linux-x64-online.run
chmod +x qt-unified-linux-x64-online.run
./qt-unified-linux-x64-online.run
```

### CAN Utilities
```bash
sudo debfoster gcc
sudo debfoster libusb-1.0-0
sudo debfoster libeigen3-dev
```

## Others
### Install Debian 9 on Dell Precision T7810
```bash
# See https://askubuntu.com/questions/657477/installaton-of-ubuntu-14-04-on-dell-precision-t7810-fails-no-boot-device-found

# Setup BIOS:
# * Boot Mode: UEFI
# * Secure Boot: Off

# 1. Install Debian 9 on Dell Precision T7810

# 2. Re-enter rescure mode, and run
mount -t vfat /dev/sda1 /mnt
mkdir -p /mnt/EFI/BOOT
cp /mnt/EFI/debian/grubx64.efi /mnt/EFI/BOOT/BOOTX64.EFI

# 3. Reboot
```

### X screen locker
```bash
sudo debfoster xtrlock
xtrlock -f && top
```

### Immigrate Debian
```bash
sudo debfoster xorg fontconfig openbox tint2 obconf obmenu lxappearance ibus-libpinyin geany xfe mupdf firefox-esr

# Restore files/dirs :
#   .config
#   .gitconfig
#   .local/share
#   .mozilla
#   .gtkrc-2.0
#   .gtkrc-2.0.mine
#   .Xresources.d
#   .Xresources
#   .xinitrc
```
