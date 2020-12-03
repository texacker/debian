#!/usr/bin/bash

# catkin Workspace
export CATKIN_WS_PATH="$HOME/workspace/zxy/src/catkin_ws"

# Set ROS alias command
alias cw='cd $CATKIN_WS_PATH'
alias cs='cd $CATKIN_WS_PATH/src'
alias cm='( cd $CATKIN_WS_PATH && catkin_make )'

# Set ROS
if [ -f /opt/ros/noetic/setup.bash ] ; then
    source /opt/ros/noetic/setup.bash

    # Set ROS Network
    if [ -n "$ROS_VERSION" ]; then
        export ROS_MASTER_URI=http://$(hostname):11311
        export ROS_HOSTNAME=$(hostname)
    fi

    # Set catkin Workspace
    if [ -f $CATKIN_WS_PATH/devel/setup.bash ] ; then
        source $CATKIN_WS_PATH/devel/setup.bash
    fi
fi

