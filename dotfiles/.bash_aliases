# some more ls aliases
#alias l='ls -CF'
alias ll='ls -lAF'
alias la='ls -AF'

# some useful aliases
alias tmux='tmux -2'
alias more='less -R'
#alias suapt='sudo apt update && sudo apt upgrade'
#alias sush='sudo shutdown -P now'
alias pdfcut='pdfnup --nup 1x1 --no-landscape'
alias ps='ps axlfww'
#alias scrot='scrot -e "mv $f ~/.scrot"'
alias minicom='minicom -c on --capturefile=$HOME/.minicom/minicom.log'
alias astyle='astyle --style=bsd -s4 -n'

# Set ROS alias command
alias cw='cd ~/workspace/ros/catkin_ws/'
alias cs='cd ~/workspace/ros/catkin_ws/src'
alias cm='( cd ~/workspace/ros/catkin_ws/ && catkin_make )'
