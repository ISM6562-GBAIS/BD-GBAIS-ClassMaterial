#!/usr/bin/env bash

# The following prunes images, containers, and networks. 
# NOTE: Volumes aren't pruned by default, and you must specify 
# the --volumes flag for docker system prune to prune volumes.

while true; do
    read -p "Do you wish to prune volumes as well? " yn
    case $yn in
        [Yy]* ) docker system prune --volumes; break;;
        [Nn]* ) docker system prune; break;;
        * ) echo "Cancelling";break;;
    esac
done

# docker system prune
# docker system prune --volumes
