# Making Docker Cloudera Container Persistent

Overview: 
To make Coudera persistent, we need to create a volume and mount it to the container. This will allow the data to be stored on the host machine and not be lost when the container is stopped or removed. Also, we may wish to create a volume simply for the purpose of sharing data between the host and the container. In the instructions below, we will do both. 

> NOTE: In summary: Creating and sharing a volume is generally easy, but in the case of Cloudera, if we wish to persist the systems data (i.e. HDFS, Hive, etc.), we need to create a temp volume and mount it to the container, then connect to the container and copy the data to the temp volume. Then, we stop the container, and mount the copied data to the system data folder in cloudera. 


## Step1:

Use the following docker-compose-step1.yaml file to start the container with a volume by running `docker-compose -f docker-compose-step1.yaml up -d`.

```yaml
version: '3'

services:
  cloudera:
    container_name: "Cloudera"
    image: "cloudera/quickstart:latest"
    hostname: quickstart.cloudera
    privileged: true
    command: /usr/bin/docker-quickstart 
    stdin_open: true # keep process stdin open awaiting connect (keeps cloudera running)
    tty: true # specifies that stdin should be a terminal
    ports: # see port list https://docs.cloudera.com/cdp-private-cloud-base/latest/installation/topics/cdpdc-ports-used-by-runtime.html
      - 80:80       # quickstart
      - 8020:8020   # HDFS 
      - 2222:2222   # SSH
      - 7180:7180   # Cloudera Manager
      - 8888:8888   # Hue (8888 is sometimes used by jupyter, need to avoid collision) uname/pword=cloudera/cloudera
      - 11000:11000 # Oozie
      - 50070:50070 # HDFS Rest Namenode
      - 50075:50075 # HDFS Rest Datanode
      - 2181:2181   # Zookeeper
      - 8032:8032   # yarn.resourcemanager.address
      - 8033:8033   # yarn.resourcemanager.admin.address
      - 8088:8088   # yarn.resourcemanager.webapp.address
      - 8090:8090   # yarn.resourcemanager.webapp.https.address
      - 8042:8042   # yarn.nodemanager.webapp.address
      - 8044:8044   # yarn.nodemanager.webapp.https.address
      - 19888:19888 # MapReduce Job History
      - 50030:50030 # MapReduce Job Tracker
      - 8983:8983   # Solr
      - 16000:16000 # Sqoop Metastore
      - 60010:60010 # HBase Master
      - 60030:60030 # HBase Region
      - 9090:9090   # HBase Thrift
      - 8080:8080   # HBase Rest
      - 7077:7077   # Spark Master
      - 9083:9083   # Metastore	
      - 10000:10000 # HiveServer2	10000	hive.server2.thrift.port	
      - 10002:10002 # HiveServer2 Web User Interface (UI)	  
    restart: always
    volumes: 
      # you must create the folder shared-storage in the same directory as the docker-compose.yaml file
      - ./shared-storage:/home/cloudera/shared-storage
    deploy: 
      resources:
        limits:
          cpus: '4'
          memory: 8G
```

## Step 2:

Copy the contents of the /var/lib/ directory to the shared-storage directory. 

Attached to the running container with the following command:
```bash
docker exec -it Cloudera bash
```

Once attached, run the following command to copy the contents of the /var/lib/ directory to the shared-storage directory:
```bash
sudo cp -rfp /var/lib/ /home/cloudera/shared-storage
```

## Step 3:

Stop the container and remove it. 

```bash
docker compose -f docker-compose-step1.yaml down
```

## Step 4:

Move the shared folder to a folder named persistent storage. Then update the docker-compose.yaml file to mount the persistent storage folder to the container. 

```bash
mv shared-storage persistent-storage
```

Update the docker-compose.yaml file to mount the persistent-storage folder to the container. This file has been provided to you as docker-compose-step4.yaml. To use it, run `docker-compose -f docker-compose-step4.yaml up -d`.

```yaml
version: '3'

services:

  cloudera:
    container_name: "Cloudera"
    image: "cloudera/quickstart:latest"
    hostname: quickstart.cloudera
    privileged: true
    command: /usr/bin/docker-quickstart 
#    command: "/home/cloudera/clouder-manager --express" - only run this if you want the cloudera manager (it normally isn't required)
    stdin_open: true # keep process stdin open awaiting connect (keeps cloudera running)
    tty: true # specifies that stdin should be a terminal
    ports: # see port list https://docs.cloudera.com/cdp-private-cloud-base/latest/installation/topics/cdpdc-ports-used-by-runtime.html
      - 80:80       # quickstart
      - 8020:8020   # HDFS 
      - 2222:2222   # SSH
      - 7180:7180   # Cloudera Manager
      - 8888:8888   # Hue (8888 is sometimes used by jupyter, need to avoid collision) uname/pword=cloudera/cloudera
      - 11000:11000 # Oozie
      - 50070:50070 # HDFS Rest Namenode
      - 50075:50075 # HDFS Rest Datanode
      - 2181:2181   # Zookeeper
      - 8032:8032   # yarn.resourcemanager.address
      - 8033:8033   # yarn.resourcemanager.admin.address
      - 8088:8088   # yarn.resourcemanager.webapp.address
      - 8090:8090   # yarn.resourcemanager.webapp.https.address
      - 8042:8042   # yarn.nodemanager.webapp.address
      - 8044:8044   # yarn.nodemanager.webapp.https.address
      - 19888:19888 # MapReduce Job History
      - 50030:50030 # MapReduce Job Tracker
      - 8983:8983   # Solr
      - 16000:16000 # Sqoop Metastore
      - 60010:60010 # HBase Master
      - 60030:60030 # HBase Region
      - 9090:9090   # HBase Thrift
      - 8080:8080   # HBase Rest
      - 7077:7077   # Spark Master
      - 9083:9083   # Metastore	
      - 10000:10000 # HiveServer2	10000	hive.server2.thrift.port	
      - 10002:10002 # HiveServer2 Web User Interface (UI)	  
    restart: always
    volumes: 
      - ./persistent-storage:/var/lib
      - ./shared-storage:/home/cloudera/shared-storage
    deploy: 
      resources:
        limits:
          cpus: '4'
          memory: 8G

```

## Step 5:

Start the container with the updated docker-compose.yaml file. 

```bash
docker-compose up -d
```


  