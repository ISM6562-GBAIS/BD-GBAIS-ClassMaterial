#!/usr/bin/env bash

# The following command prunes (removes) any image not currently used by at least one container.

docker image prune -a
