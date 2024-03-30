#!/usr/bin/env bash

# The following prunes images, containers, and networks. 
# NOTE: Volumes aren't pruned by default, and you must specify 
# the --volumes flag for docker system prune to prune volumes.

while true; do
    read -p "Do you wish to remove all containers (both running and stopped) (A) or only stopped containers (S)?" as
    case $as in
        [Aa]* ) docker ps -aq | xargs docker stop | xargs docker rm; break;;
        [Ss]* ) docker ps -aq | xargs docker rm; break;;
        * ) echo "Cancelling";break;;
    esac
done

# docker system prune
# docker system prune --volumes
