#!/bin/bash
docker exec avorion_server screen -S avorion -X stuff '/save'^M
docker exec avorion_server screen -S avorion -X stuff '/stop'^M
