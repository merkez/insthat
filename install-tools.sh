#!/bin/bash 

## This script can be extended in time to include more tools to install if required

PROGRAMS=(git vim zsh curl wget tree htop virtualbox) 
IS_EXISTS() {
    if command -v $1 >/dev/null 
    then
        echo "$1 already exists"
    else
        echo "Installing $1..."
        apt install -y $1
    fi 
}   

if [[ $EUID -ne 0 ]]; then  
   	echo "This script must be run as root" 
   	exit 1
else
   echo "This script will install the following packages:"
    echo "* git"
    echo "* vim"
    echo "* zsh"
    echo "* curl"
    echo "* wget"
    echo "* htop"
    echo "* tree"
    echo "* virtualbox"
    echo "* vagrant"

    for i in "${!PROGRAMS[@]}"; do
       IS_EXISTS ${PROGRAMS[$i]}
    done 

    echo "Would you like to install docker engine ? (y/n)"
    read response
    if [  "$response" != "${response#[Yy]}" ]; then
        if command -v docker >/dev/null 
        then
            echo "Docker already exists"
        else
            echo "Installing Docker..."
            curl -fsSL https://get.docker.com -o get-docker.sh
            sh get-docker.sh
            echo "Adding $USER to docker group..."
            usermod -aG docker $USER
            echo "Enabling docker service..."
            systemctl enable docker
            echo "Starting docker service..."
            systemctl start docker
            rm get-docker.sh
        fi
    else
        echo "Exiting without installing docker engine"
        exit 1
    fi
      
fi

