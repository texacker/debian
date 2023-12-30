#!/usr/bin/bash

# Path

if [ -d "$HOME/.local/gcc-linaro-4.9.4-2017.01-x86_64_arm-linux-gnueabihf/bin" ] ; then
    PATH="$HOME/.local/gcc-linaro-4.9.4-2017.01-x86_64_arm-linux-gnueabihf/bin:$PATH"
fi

if [ -d "$HOME/.local/lib/pkgconfig" ] && test $(echo "$PKG_CONFIG_PATH" | awk -F ':' '{ for (i = 1; i <= NF; i++) { print $i } }' | grep -E "^$HOME/.local/lib/pkgconfig/?\$" | wc -l) -eq 0 ; then
    PKG_CONFIG_PATH="$HOME/.local/lib/pkgconfig:$PKG_CONFIG_PATH"
fi

# Workspace

# zlg
export ZLG_WS_PATH="$HOME/<your_zlg_ws>"

# Qt
export QT_WS_PATH="$HOME/<your_qt_ws>"

# ghcup-env
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env"

