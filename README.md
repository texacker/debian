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

# hostname & FQDN
# sudo hostname <your_hostname>
sudo vim /etc/hostname
sudo vim /etc/hosts
```

### Pubkey Authentication
```bash
# run ssh-keygen on remote_host :
ssh-keygen -t rsa -b 4096 -C "$(whoami)@$(hostname)-$(date -I)"

# on ssh server, edit /etc/ssh/sshd_config :
# PubkeyAuthentication            yes
# AuthorizedKeysFile              .ssh/authorized_keys .ssh/authorized_keys2
# PasswordAuthentication          no
# ChallengeResponseAuthentication no

# and restart sshd :
sudo systemctl restart sshd.service
# or
sudo service ssh restart

# add pubkey to authorized_keys :
# ssh remote_host cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
ssh-copy-id srv_user@srv_host
```

### Configure Wi-Fi on Debian 9 with Intel(R) Dual Band Wireless AC 8265
```bash
# https://wiki.debian.org/iwlwifi
# https://unix.stackexchange.com/questions/348748/how-to-configure-wi-fi-on-debian-9-stretch-with-network-card-intel-corporation-w

# Add a "non-free" component to /etc/apt/sources.list
sudo debfoster firmware-iwlwifi
sudo debfoster wpasupplicant
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

## 桌面环境
### xorg
```bash
sudo debfoster xorg fontconfig
sudo debfoster openbox tint2
sudo debfoster obconf obmenu lxappearance gcolor2
sudo debfoster ibus-libpinyin
sudo debfoster geany xfe mupdf firefox-esr
```

### Enable/disable synaptics touchpad in Debian 9
```bash
# https://unix.stackexchange.com/questions/388963/how-can-i-enable-disable-the-synaptics-touchpad-in-debian-9-with-libinput
sudo debfoster xinput

xinput list
xinput set-prop "SynPS/2 Synaptics TouchPad" "Device Enabled" 0     # Disable
xinput set-prop "SynPS/2 Synaptics TouchPad" "Device Enabled" 1     # Enable
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

### Lightweight Webserver
```bash
sudo debfoster webfs
```

### Archivers for RAR
```bash
sudo debfoster unrar-free unar
```

### Utilities for GFW :-/
```bash
sudo debfoster shadowsocks-libev supervisor proxychains
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
sudo debfoster libreoffice
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
sudo debfoster jflex cup eclipse-jdt
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

## 嵌入式系统开发
### CAN Utilities
```bash
sudo debfoster build-essential
sudo debfoster libusb-1.0-0
sudo debfoster libeigen3-dev

# SocketCAN
sudo debfoster libsocketcan-dev
sudo debfoster can-utils
```

### 串口
```bash
sudo debfoster microcom
microcom -s 115200 -p /dev/ttyUSB0

sudo debfoster minicom
sudo minicom -s
minicom -c on
```

### 3D Graphics
```bash
# nVidia Driver:
#   - https://wiki.debian.org/NvidiaGraphicsDrivers#stretch
lspci -nn | grep -i nvidia
lsmod | grep -i nouveau
sudo cp /etc/apt/sources.list /etc/apt/sources.list.orig
sudo sed -i 's/stretch main$/stretch main contrib non-free/' /etc/apt/sources.list
sudo apt update && sudo apt upgrade
sudo debfoster linux-headers-$(uname -r | sed 's/[^-]*-[^-]*-//')
sudo debfoster nvidia-driver
ll /etc/modprobe.d/
sudo reboot

# Backing out in case of failure:
#   - https://wiki.debian.org/NvidiaGraphicsDrivers/#Backing_out_in_case_of_failure
sudo apt-get purge nvidia.    # don't forget the "." dot, it erases every package with "nvidia" on its name.
sudo apt-get install --reinstall xserver-xorg
sudo apt-get install --reinstall xserver-xorg-video-nouveau
sudo reboot

# OpenGL:
sudo debfoster libglew-dev                  # OpenGL Loading Library
sudo debfoster freeglut3-dev libglfw3-dev   # API for windowing sub-systems(GLX, WGL, CGL ...)
sudo debfoster libglm-dev libassimp-dev libmagick++-dev libsoil-dev

# OpenSceneGraph:
sudo debfoster openscenegraph-3.4 libopenscenegraph-3.4-dev openscenegraph-3.4-doc openscenegraph-3.4-examples

# OGRE:
sudo debfoster libogre-1.9-dev ogre-1.9-tools blender-ogrexml-1.9 libois-dev
```

### debian 下交叉编译 ZeroMQ for ARM (i.MX6UL)
```bash
# 一：安装交叉编译工具

# apt 安装，最新版
sudo debfoster g++-arm-linux-gnueabihf

# 手动安装，可以选择旧版本
# 因为硬件环境下的 stdc++ 等的版本一般滞后，太新的交叉编译器编译出来的，拷贝过去不能运行

# zlg.cn 的 M6G2C 系统目前（2018-09-12）只支持 Latest 4
# 更新版本的交叉编译工具编译出来的可执行程序会输出类似错误：
# /usr/lib/arm-linux-gnueabihf/libstdc++.so.6: version `CXXABI_1.3.9' not found (required by /opt/usr/local/lib/libzmq.so.5)
# /usr/lib/arm-linux-gnueabihf/libstdc++.so.6: version `GLIBCXX_3.4.21' not found (required by /opt/usr/local/lib/libzmq.so.5)

wget https://releases.linaro.org/components/toolchain/binaries/latest-4/arm-linux-gnueabihf/gcc-linaro-4.9.4-2017.01-x86_64_arm-linux-gnueabihf.tar.xz
tar Jxvf -C ~/.local gcc-linaro-4.9.4-2017.01-x86_64_arm-linux-gnueabihf.tar.xz
export PATH=~/.local/gcc-linaro-4.9.4-2017.01-x86_64_arm-linux-gnueabihf/bin:$PATH

# 二：编译 libzmq
wget https://github.com/zeromq/libzmq/releases/download/v4.2.3/zeromq-4.2.3.tar.gz
tar zxvf zeromq-4.2.3.tar.gz
cd zeromq-4.2.3
./configure --help
./configure --prefix=`pwd`/dist-build/ --host=arm-linux-gnueabihf
make
make check
make install
make clean
make distclean
```

### OpenCV
```bash
# Prosilica/Aravis GigE API:
# https://wiki.gnome.org/action/show/Projects/Aravis?action=show&redirect=Aravis
# https://github.com/AravisProject/aravis
# https://www.alliedvision.com/en/support/software-downloads.html

# OpenCV:
# https://docs.opencv.org/master/d7/d9f/tutorial_linux_install.html

sudo debfoster build-essential                                                                                  # compiler
sudo debfoster cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev                 # required
sudo debfoster python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff5-dev libdc1394-22-dev  # optional
sudo debfoster libjasper-dev                                                                                    # sid (unstable) ?

mkdir -p <opencv_dir> && cd <opencv_dir>

git clone https://github.com/opencv/opencv.git
git clone https://github.com/opencv/opencv_contrib.git
git clone https://github.com/opencv/opencv_extra.git

mkdir build && cd build && \
env PVAPI_ROOT="$HOME/.opt/PvAPI_1.28_Linux/AVT_GigE_SDK" cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$HOME/.local -DBUILD_EXAMPLES=ON -DINSTALL_C_EXAMPLES=ON -DBUILD_TESTS=ON -DINSTALL_TESTS=ON -DOPENCV_EXTRA_MODULES_PATH=../opencv_contrib/modules -DWITH_PVAPI=ON ../opencv && \
make -j && \
env OPENCV_TEST_DATA_PATH=../opencv_extra/testdata/ ./bin/opencv_test_core && \
make install clean
```

### Fiducial Markers
#### ArUco
```bash
# http://www.uco.es/investiga/grupos/ava/node/25
# https://sourceforge.net/projects/aruco/

sudo debfoster libeigen3-dev

mkdir -p <aruco_dir> && cd <aruco_dir>
# Download ArUco from : https://sourceforge.net/projects/aruco/files/latest/download
unzip aruco-3.0.13.zip

mkdir build && cd build && \
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=$HOME/.local -DCMAKE_INSTALL_PREFIX=$HOME/.local -DUSE_OWN_EIGEN3=OFF ../aruco-3.0.13
make -j
make install
make clean

# Calibrate Camera :
env LD_LIBRARY_PATH=~/.local/lib/ ~/.local/bin/aruco_calibration_fromimages LUMIX-LX3.yml . -size 0.035

# Print marker :
env LD_LIBRARY_PATH=~/.local/lib/ ~/.local/bin/aruco_print_marker 70 ./ARUCO_MIP_36h12_00070.png -e -bs 300

# Print Customized Dictionary :
env LD_LIBRARY_PATH=~/.local/lib/ ~/.local/bin/aruco_print_dictionary <pathToSaveAllImages> <pathTo/myown.dict>

# Detect Marker :
env LD_LIBRARY_PATH=~/.local/lib/ ~/.local/bin/aruco_simple ./P1010976.png -c ./calibration/png/LUMIX-LX3.yml -s 0.166

# Note: OpenCV4/aruco 与 aruco-3.0.13 版本差异见：opencv2/aruco.hpp

# Note: if don't want it any more:
# make uninstall
```

#### MarkerMapper
```bash
# http://www.uco.es/investiga/grupos/ava/node/25
# https://sourceforge.net/projects/markermapper/

mkdir -p <markermapper_dir> && cd <markermapper_dir>
# Download MarkerMapper from : https://sourceforge.net/projects/markermapper/files/latest/download
unzip marker_mapper1.0.12.zip

mkdir build && cd build && \
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=$HOME/.local -DCMAKE_INSTALL_PREFIX=$HOME/.local -DUSE_OWN_EIGEN3=OFF ../marker_mapper1.0.12
make -j
make install
make clean
```

### ROS
```bash
# http://wiki.ros.org/melodic/Installation/Debian

sudo debfoster chrony ntpdate
sudo ntpdate [ -q ] ntp.ubuntu.com

sudo debfoster dirmngr
sudo debfoster libpcl-dev

sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
sudo apt update && sudo apt upgrade
sudo debfoster ros-melodic-desktop-full
sudo debfoster python-rosinstall python-rosinstall-generator python-wstool build-essential

sudo rosdep init
rosdep update

source /opt/ros/melodic/setup.bash
mkdir -p <your_catkin_ws>/src
cw && ( cd ./src && catkin_init_workspace ) && catkin_make && source ./devel/setup.bash
```

### PCL
```bash
# http://www.pointclouds.org/documentation/
sudo debfoster dirmngr libpcl-dev pcl-tools
```

### CGAL
```bash
# https://www.cgal.org/download/linux.html
sudo debfoster libmpfi-dev libmetis-dev libntl-dev libqt5svg5 ipe

cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$HOME/.local -DWITH_examples=true -DWITH_demos=true ../CGAL-4.14
make
make demos
make examples
make install clean

# or through apt:
sudo debfoster libcgal-dev libcgal-demo libcgal-qt5-dev libcgal-ipelets
```
