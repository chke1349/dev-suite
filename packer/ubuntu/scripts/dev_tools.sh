#!/bin/sh -eux
export DEBIAN_FRONTEND=noninteractive

echo "Add docker repository"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

echo "Add Java 11 LTS (AdoptOpenJdk) repository"
wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | apt-key add -
add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/

echo "Install docker, necessary libraries for guest additions, Vagrant NFS Share"
apt-get -y -q install docker-ce docker-ce-cli containerd.io adoptopenjdk-11-hotspot adoptopenjdk-11-hotspot-jre
echo "Add vagrant user to docker group"
usermod -aG docker vagrant

echo "Install docker-compose"
if [ ! -f /usr/bin/docker-compose ]; then
  curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  chmod +x /usr/local/bin/docker-compose
  ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
fi

echo "Install IntelliJ Community"
snap install intellij-idea-community --classic

echo "Install NodeJs LTS"
curl -sL https://deb.nodesource.com/setup_lts.x | bash -
apt-get install -y nodejs

echo "Install Kubectl"
snap install kubectl --classic
