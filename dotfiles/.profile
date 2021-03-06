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

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# .profile 与 .bashrc 的关系：
#   https://blog.csdn.net/m0_37739193/article/details/72638074
#   https://www.helplib.com/ubuntu/article_161754
#
# .profile : login script
# .bashrc  : interactive script，即只包含与**交互**有关部分（例如提示符、颜色、别名缩写等等）的脚本

if [ -f "$HOME/.bash_local_env.bash" ]; then
    . "$HOME/.bash_local_env.bash"
fi

if [ -f "$HOME/.bash_local_ros.bash" ]; then
    . "$HOME/.bash_local_ros.bash"
fi

