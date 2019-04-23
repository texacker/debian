# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# .profile 与 .bashrc 的关系：
#   https://blog.csdn.net/m0_37739193/article/details/72638074
#   https://www.helplib.com/ubuntu/article_161754
#
# .profile : login script
# .bashrc  : interactive script，即只包含与**交互**有关部分（例如提示符、颜色、别名缩写等等）的脚本

if [ -d "$HOME/.local/gcc-linaro-4.9.4-2017.01-x86_64_arm-linux-gnueabihf/bin" ] ; then
    PATH="$HOME/.local/gcc-linaro-4.9.4-2017.01-x86_64_arm-linux-gnueabihf/bin:$PATH"
fi

# Set ROS Melodic
source /opt/ros/melodic/setup.bash
source ~/workspace/ros/catkin_ws/devel/setup.bash

# Set ROS Network
export ROS_MASTER_URI=http://$(hostname):11311
export ROS_HOSTNAME=$(hostname)
