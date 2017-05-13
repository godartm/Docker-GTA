# ==================
#  GTARP Dockerfile
#   PrivateHeberg©
# ==================

FROM debian:8
MAINTAINER privateHeberg

# ==== Variables ==== #
# === Non necessaire pour le moment ===#
# =================== #

# ==== Paquets ==== #
RUN apt-get update &&\
    apt-get upgrade -y &&\
    apt-get install -y curl &&\
    apt-get install -y p7zip-full

RUN apt-get install -y monodevelop

# ================= #

# ==== Gta user ==== #
RUN adduser \
	--disabled-login \
	--shell /bin/bash \
	--gecos "" \
	gta
RUN usermod -a -G sudo gta
# ==================== #

# ==== Scripts ==== #
COPY run.sh /home/gta/run.sh
RUN touch /root/.bash_profile
RUN chmod 777 /home/gta/run.sh
RUN mkdir  /data
RUN chown gta -R /data && chmod 755 -R /data
# ================= #

# ==== Volumes ==== #
VOLUME  /data
WORKDIR /data
# ================= #
cd /data

curl -O http://updater.fivereborn.com/client/cfx-server.7z

mkdir fivem-server && 7za x cfx-server.7z && mv cfx-server/* fivem-server && rm -r cfx-server

cd fivem-server

chmod +x run.sh

ENTRYPOINT ["/home/gta/run.sh"]
