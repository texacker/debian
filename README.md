# Debian 使用笔记

## 安装 Debian Base

### [Download media](https://www.debian.org/distrib/netinst) from [mirrors](https://www.debian.org/CD/http-ftp/#mirrors) and [write image to USB](https://www.debian.org/CD/faq/#write-usb)
```bash
wget http://mirrors.163.com/debian-cd/current/amd64/iso-cd/debian-9.3.0-amd64-netinst.iso
wget http://mirrors.163.com/debian-cd/current/amd64/iso-cd/SHA1SUMS
shasum -c SHA1SUMS
sudo dd if=debian-9.3.0-amd64-netinst.iso of=/dev/da0 bs=4M; sync
```

### Locale
```bash
vi /etc/default/locale
dpkg-reconfigure locales    # choose en_US.UTF-8(default), zh_CN.UTF-8
```

## 安装 Packages
### Packages Management
```bash
apt-get install debfoster
```

### xorg
```bash
debfoster xorg fontconfig
debfoster openbox tint2 obconf obmenu lxappearance
debfoster ibus-libpinyin
debfoster geany xfe mupdf firefox-esr
```

### Qt Creator
```bash
# See http://wiki.qt.io/Install_Qt_5_on_Ubuntu
debfoster build-essential
debfoster libgl1-mesa-dev
debfoster gdb git clang
```

### CAN Utilities
```bash
debfoster gcc
debfoster libusb-1.0-0
debfoster libeigen3-dev
```
