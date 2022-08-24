FROM ubuntu:20.04

ARG SERVER_DIR
ARG STEAMCMD_DIR
ARG GALAXY_DIR
ARG BACKUP_DIR
ARG GALAXY_NAME
ARG PORT

RUN apt update && apt upgrade -y
RUN dpkg --add-architecture i386
RUN apt install -y software-properties-common
RUN add-apt-repository multiverse
RUN apt update
RUN apt install -y lib32gcc-s1 \
	curl \
	screen

RUN mkdir /root/.avorion/backups -p
RUN ln -s $BACKUP_DIR /root/.avorion/backups
RUN mkdir $STEAMCMD_DIR
RUN cd $STEAMCMD_DIR && curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf - && cd

VOLUME $GALAXY_DIR
VOLUME $BACKUP_DIR

WORKDIR $SERVER_DIR

RUN $STEAMCMD_DIR/steamcmd.sh +force_install_dir $SERVER_DIR +login anonymous +app_update 565060 validate +exit

EXPOSE $PORT/udp
EXPOSE $PORT/tcp
EXPOSE 27003/udp
EXPOSE 27020/udp
EXPOSE 27021/udp

RUN echo $GALAXY_NAME
RUN echo $GALAXY_DIR

CMD screen -S avorion ./server.sh --galaxy-name $GALAXY_NAME  --datapath $GALAXY_DIR
