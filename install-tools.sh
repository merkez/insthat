#!/bin/bash 

## This script can be extended in time to include more tools to install if required

ESSENTIALS=(git vim zsh curl wget tree htop build-essential cmake) 

PROGRAMS=( "goland:INSTALL_GOLAND"
        "vagrant:INSTALL_VAGRANT"
        "go:INSTALL_GO"
        "docker:INSTALL_DOCKER_ENGINE"
        "virtualbox:INSTALL_VIRTUALBOX"
         )

BLUE="\033[0;34m"
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
NC="\033[0m" 

INSTALL_GO() {
   printf "${YELLOW}Installing Go 1.18\n"
   curl -fsSL https://golang.org/dl/go1.18.linux-amd64.tar.gz -o /tmp/go.tar.gz
   tar -C /usr/local -xzf /tmp/go.tar.gz
   rm /tmp/go.tar.gz
   printf "${RED}DO NOT FORGET TO ADD go to path...\n"
   printf "${RED}hint: export PATH=$PATH:/usr/local/go/bin  >> /home/$USER/.bashrc${NC}\n" 
}

INSTALL_GOLAND() {
    printf "${YELLOW}Installing Goland...${NC}\n"
    curl -fsSL https://download.jetbrains.com/go/goland-2022.1.tar.gz -o /tmp/goland.tar.gz
    tar -C /opt -xzf /tmp/goland.tar.gz
    rm /tmp/goland.tar.gz
}

INSTALL_VAGRANT() {
    printf "${YELLOW}Installing Vagrant...${NC}\n"
    curl -fsSL https://releases.hashicorp.com/vagrant/2.2.19/vagrant_2.2.19_x86_64.deb -o /tmp/vagrant.deb
    dpkg -i /tmp/vagrant.deb
    rm /tmp/vagrant.deb
}

INSTALL_DOCKER_ENGINE() {
    printf "${YELLOW}Installing Docker...${NC}\n"
    curl -fsSL https://get.docker.com -o get-docker.sh
    sh get-docker.sh
    printf "${YELLOW}Adding $USER to docker group...\n"
    usermod -aG docker $USER
    printf "${YELLOW} Enabling docker service...\n"
    systemctl enable docker
    printf "${YELLOW} Starting docker service...${NC}\n"
    systemctl start docker
    rm get-docker.sh
}
INSTALL_VIRTUALBOX() {
    printf "${YELLOW}Installing VirtualBox...${NC}\n"
    curl -fsSL https://download.virtualbox.org/virtualbox/6.1.4/virtualbox-6.1_6.1.4-139181~Ubuntu~bionic_amd64.deb -o /tmp/virtualbox.deb
    dpkg -i /tmp/virtualbox.deb
    rm /tmp/virtualbox.deb
}

if [[ $EUID -ne 0 ]]; then  
   	printf "${RED}This script must be run as root\n" 
   	exit 1
else
    printf "${GREEN}********************************************************${NC}\n"
    printf "${GREEN}*  INSTALLING ESSENTIAL PACKAGES & OPTIONAL PROGRAMS   *${NC}\n"
    printf "${GREEN}********************************************************${NC}\n"
    printf "${BLUE}Updating apt-get...${NC}\n"
    apt update 
    printf "${GREEN}--------------------------------------------------------${NC}\n"
    printf "${YELLOW}This script will install the following packages: ${NC}\n"
    printf "[ ${YELLOW}${ESSENTIALS[*]}${NC} ]\n\n"
    printf "${YELLOW}Would like to continue ? [y/n] ${NC}\n"
    read -r response
    if [  "$response" != "${response#[Yy]}" ]; then
        for i in "${ESSENTIALS[@]}" ; do
            printf "\n${BLUE}Installing  $i ${NC}\n"
            printf "${BLUE}********************************************************${NC}\n"
            apt install -y $i
        done
    else 
        printf "${RED}Exiting without installing essentials \n"
        printf "${RED}--------------------------------------------------------${NC}\n"
        printf "${RED}Next installation steps may NOT run, since install essentials did not work${NC}\n"
    fi

  
    for tool in "${PROGRAMS[@]}" ; do
        KEY=${tool%%:*}
        VALUE=${tool#*:}
        printf "${BLUE}Would you like to install $KEY ? (y/n)${NC}\n"
        read -r response
        if [  "$response" != "${response#[Yy]}" ]; then
            $VALUE
        else
            printf "${RED}Exiting without installing $KEY ${NC}\n"
        fi
    done
   
   printf "${YELLOW}--------------------------------------------------------${NC}\n\n"

   printf "${GREEN}Thanks for using the script ! ${NC}\n"
   printf "${GREEN}********************************************************${NC}\n"
   printf "${GREEN}If you like it, a star would be nice on github: https://github.com/merkez/install-tools\n"
   printf "If you have any request/fix, please create an issue at https://github.com/merkez/install-tools/issues/new\n"
   printf "${GREEN}********************************************************${NC}\n"
   printf "\n"

fi
