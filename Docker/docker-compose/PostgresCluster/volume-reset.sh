#!/bin/bash
echo "Stopping Postgres Cluster"
docker compose stop
echo "Removing PgAdmin volumes"
docker volume rm pgadmin_data
docker volume rm pgadmin_data_cluster
echo "Finished: You must now start the cluster using 'docker compose up'"