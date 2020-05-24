export DIST=bionic
export ORACLE_VBOX_KEY=oracle_vbox_2016.asc
sudo apt-get install linux-headers-$(uname -r)
echo "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian ${DIST} contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list
wget "https://www.virtualbox.org/download/${ORACLE_VBOX_KEY}"
sudo apt-key add $ORACLE_VBOX_KEY
rm -f $ORACLE_VBOX_KEY
sudo apt-get -y update
sudo apt-get -y install virtualbox-6.1