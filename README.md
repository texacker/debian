# Debian 使用笔记

## 安装

### [Download media] from [mirrors](https://www.debian.org/CD/http-ftp/#mirrors)(https://www.debian.org/distrib/netinst) and [write image to USB](https://www.debian.org/CD/faq/#write-usb)
```bash
wget https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-9.3.0-amd64-netinst.iso
dd if=debian-9.3.0-amd64-netinst.iso of=/dev/da0 bs=4M; sync
```
