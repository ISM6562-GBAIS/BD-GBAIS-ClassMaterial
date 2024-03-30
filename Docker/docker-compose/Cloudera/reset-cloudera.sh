#!/bin/bash

# Stop and remove the Cloudera Docker container
docker stop Cloudera
docker rm Cloudera

# Change to the Cloudera directory
cd /home/admin/Workspace/bd24-STUDENT/Docker/Cloudera

# Bring up the Cloudera Docker container using Docker Compose
docker-compose up -d
