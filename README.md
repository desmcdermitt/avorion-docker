# avorion-docker
Docker setup for Avorion Steam Server

* start server while in the avorion-docker repo folder
```
docker-compose -d up --build
```

* Exit the server with:
  * this will save and then stop the server 
```
docker exec avorion_server /bin/bash /avorion/stop_server.sh
```

* Galaxies will be saved to the `galaxies` local folder
* Backups will be save to the `backups` local folder

* To edit server setting:
Once the initial startup is complete stop the server.  
Then edit the `server.ini` file in `galaxies/{GALAXY_NAME}/` 
Start the container

* To change various setting edit `.env` file
