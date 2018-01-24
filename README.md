# Debian 使用笔记

## 安装

### [Download media](https://www.debian.org/distrib/netinst) from [mirrors](https://www.debian.org/CD/http-ftp/#mirrors) and [write image to USB](https://www.debian.org/CD/faq/#write-usb)
```bash
wget http://mirrors.163.com/debian-cd/current/amd64/iso-cd/debian-9.3.0-amd64-netinst.iso
wget http://mirrors.163.com/debian-cd/current/amd64/iso-cd/SHA1SUMS
shasum -c SHA1SUMS
dd if=debian-9.3.0-amd64-netinst.iso of=/dev/da0 bs=4M; sync
```
