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

    echo "Would you like to install vagrant ? (y/n)"
    if [  "$response" != "${response#[Yy]}" ]; then
        if command -v vagrant >/dev/null 
        then
            echo "Vagrant already exists"
        else
            echo "Installing Vagrant..."
            curl -fsSL https://raw.githubusercontent.com/hashicorp/vagrant/master/keys/vagrant.pub -o /home/$USER/.ssh/authorized_keys
            curl -fsSL https://releases.hashicorp.com/vagrant/2.2.5/vagrant_2.2.5_x86_64.deb -o /tmp/vagrant.deb
            dpkg -i /tmp/vagrant.deb
            rm /tmp/vagrant.deb
        fi
    else
        echo "Exiting without installing vagrant"
        exit 1
    fi

    echo "Would you like to install vs code ? (y/n)"
    if [  "$response" != "${response#[Yy]}" ]; then
        if command -v code >/dev/null 
        then
            echo "VSCode already exists"
        else
            echo "Installing VSCode..."
            curl -L https://go.microsoft.com/fwlink/?LinkID=760868 -o /tmp/vscode.deb
            dpkg -i /tmp/vscode.deb
            rm /tmp/vscode.deb
        fi
    else
        echo "Exiting without installing vs code"
        exit 1
    fi

    echo "Would you like to install go ? (y/n)"
    if [  "$response" != "${response#[Yy]}" ]; then
        if command -v go >/dev/null 
        then
            echo "Go already exists"
        else
            echo "Installing Go 1.18"
            curl -fsSL https://golang.org/dl/go1.18.linux-amd64.tar.gz -o /tmp/go.tar.gz
            tar -C /usr/local -xzf /tmp/go.tar.gz
            rm /tmp/go.tar.gz
            echo "Adding go to path..."
            echo "export PATH=$PATH:/usr/local/go/bin" >> /home/$USER/.bashrc
        fi
    else
        echo "Exiting without installing go"
        exit 1
    fi    

    echo "Would you like to install goland ? (y/n)"
    if [  "$response" != "${response#[Yy]}" ]; then
        if command -v goland >/dev/null 
        then
            echo "Goland already exists"
        else
            echo "Installing Goland..."
            curl -fsSL https://download.jetbrains.com/go/goland-2022.1.tar.gz -o /tmp/goland.tar.gz
            tar -C /opt -xzf /tmp/goland.tar.gz
            rm /tmp/goland.tar.gz
            echo "Adding goland to path..."
            echo "export PATH=$PATH:/opt/goland-2022.1/bin" >> /home/$USER/.bashrc
        fi
    else
        echo "Exiting without installing goland"
        exit 1
    fi

fi
