# Match GitHub Runner version as kernel modules need to be built
FROM ubuntu:18.04

RUN export DEBIAN_FRONTEND=noninteractive \
  && export DIST=bionic \
  && export ORACLE_VBOX_KEY=oracle_vbox_2016.asc \
  && apt-get -y update \
  && apt-get -y install apt-utils \
  && apt-get -y upgrade \
  && apt-get -y install wget gnupg2 \
  && apt-get -y install build-essential linux-headers-azure systemd \
  && echo "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian ${DIST} contrib" > /etc/apt/sources.list.d/virtualbox.list \
  && wget "https://www.virtualbox.org/download/${ORACLE_VBOX_KEY}" \
  && apt-key add $ORACLE_VBOX_KEY \
  && rm -f $ORACLE_VBOX_KEY \
  && apt-get -y update \
  && apt-get -y install virtualbox-6.1 \
  && apt-get -y autoremove \
  && apt-get -y clean

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]