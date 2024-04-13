# MongoDB Container

Make sure that persistent-storage-1 and shared-storage-1 folders exist in this folder. These are used by the MongoDB docker image to store persistent data.

Prior to running this container, be sure you've created the scripts folder and have included the rs-initiate.js file. This should already be part of the repo. 

To get the system up an running, run the following:
```docker-compose up```

When finished, be sure to stop the server by running the following:
```docker-compose stop``` (or, in the terminal window that you started the container, simply hit ctrl-c)
