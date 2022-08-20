FROM ubuntu:20.04

ENV GALAXY_NAME="AVGalaxy"
ENV SERVER_DIR=/avorion
ENV GALAXY_DIR=/galaxies
ENV STEAMCMD_DIR=/steamcmd
ENV BACKUP_DIR=/backups

RUN apt update && apt upgrade -y
RUN dpkg --add-architecture i386
RUN apt install -y software-properties-common
RUN add-apt-repository multiverse
RUN apt update
RUN apt install -y lib32gcc-s1 \
	curl \
	screen

RUN mkdir $STEAMCMD_DIR
RUN cd $STEAMCMD_DIR && curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf - && cd

RUN mkdir $SERVER_DIR
RUN mkdir $GALAXY_DIR
VOLUME $GALAXY_DIR
VOLUME $BACKUP_DIR

WORKDIR $SERVER_DIR

RUN $STEAMCMD_DIR/steamcmd.sh +force_install_dir $SERVER_DIR +login anonymous +app_update 565060 validate +exit

EXPOSE 27000/udp
EXPOSE 27000/tcp
EXPOSE 27003/udp
EXPOSE 27020/udp
EXPOSE 27021/udp

COPY . $SERVER_DIR

CMD ln -s $BACKUP_DIR /root/.avorion/backups
CMD screen -S avorion ./server.sh --galaxy-name $GALAXY_NAME --datapath $GALAXY_DIR
