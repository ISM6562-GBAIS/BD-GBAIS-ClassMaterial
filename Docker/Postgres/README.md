
**Make sure the folders `pgdb-persistent-storage` and `pgadmin-persistent-storage` exist in this folder. If not, simply create these folders `mkdir pgdb-persistent-storage` and `mkdir pgadmin-persistent-storage`

# Starting Postgres and PGAdmin containers and logging into PGAdmin

```bash
docker-compose up
```

Wait until both the postgres and pgamin servers are started. You will see when this is complete by looking at the screen output from the docker-compose command.

Once both containers are fully running, then log into pgadmin.
* start web browser
* go to address ```localhost:8888```
* enter username ```student@usf.edu``` and password ism6562

# Technical Notes

## Updating User Credentials in docker-compose.yaml

When modifying the username and password in the docker-compose.yaml file, it's important to note that these changes will not automatically reflect in the persistent containers. This is because the original credentials from the initial deployment are retained in the Docker volumes.

### Steps to Update Credentials

* **1. Remove Existing Volumes**: To update the credentials, you first need to delete the current Docker volumes. This action ensures the removal of all persistent data, including the old usernames and passwords.

* Warning: The following command will delete all existing Docker volumes, so use it with caution:

``` bash
docker-compose down -v
```

This command stops and removes the containers, networks, and volumes defined in your ```docker-compose.yaml```.

* **2. Re-run docker-compose.yaml**: After removing the volumes, you can now run the docker-compose.yaml file again. This step will recreate the volumes with the new username and password.

``` bash
    docker-compose up -d
```

### Removing Specific Volumes

If you prefer to remove specific volumes instead of all, follow these steps:

1. Identify the Volume: Use the following command to list all containers (both running and stopped). This helps in identifying the name of the container associated with the volume you want to remove.

```bash
docker ps -a
```

2. Remove Specific Volume: Replace <container_name> with the appropriate container name in the command below:

```bash
docker-compose rm -s <container_name>
```

For example, to remove the pgadmin and pgdb volumes, use:

```bash
docker-compose rm -s pgadmin
docker-compose rm -s pgdb
```

### Important Considerations

* Data Loss: Be aware that removing volumes results in the loss of **all** data stored in them. Ensure you have backups if needed.
* Volume Management: Regularly monitor and manage Docker volumes to avoid storage issues, especially when frequently changing configurations.