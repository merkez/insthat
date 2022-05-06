#!/bin/bash 

## This script can be extended in time to include more tools to install if required

ESSENTIALS=(git vim zsh curl wget tree htop build-essential cmake) 
PROGRAMS_ARR=(goland pycharm intellij rubymine sublime 
 vagrant go docker
 virtualbox nodejs yarn ninja 
 rust boostlib venv anaconda 
 adoptopenjdk ffmpeg) 

declare -A PROGRAMS=(
    [goland]="INSTALL_GOLAND"
    [pycharm]="INSTALL_PYCHARM"
    [intellij]="INSTALL_INTELLIJ"
    [rubymine]="INSTALL_RUBYMINE"
    [sublime]="INSTALL_SUBLIME"
    [vagrant]="INSTALL_VAGRANT"
    [go]="INSTALL_GO"
    [docker]="INSTALL_DOCKER"
    [virtualbox]="INSTALL_VIRTUALBOX"
    [nodejs]="INSTALL_NODEJS"
    [yarn]="INSTALL_YARN"
    [ninja]="INSTALL_NINJA"
    [rust]="INSTALL_RUST"
    [boostlib]="INSTALL_BOOSTLIB"
    [venv]="INSTALL_VENV"
    [anaconda]="INSTALL_ANACONDA"
    [adoptopenjdk]="INSTALL_ADOPTOPENJDK"
    [ffmpeg]="INSTALL_FFMPEG"
    [telegram]="INSTALL_TELEGRAM"
)

JETBRAINS_VERSION="2022.1"
VAGRANT_VERSION="2.2.19"
GO_VERSION="1.18"

BLUE="\033[0;34m"
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
NC="\033[0m" 

INSTALL_GO() {
   printf "${YELLOW}Installing Go ${GO_VERSION}\n"
   curl -fsSL https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz -o /tmp/go.tar.gz
   tar -C /usr/local -xzf /tmp/go.tar.gz
   rm /tmp/go.tar.gz
   printf "${RED}DO NOT FORGET TO ADD go to path...\n"
   printf "${RED}hint: export PATH=$PATH:/usr/local/go/bin  >> /home/$USER/.bashrc${NC}\n" 
}

INSTALL_PYCHARM() {
    printf "${YELLOW}Installing PyCharm\n"
    wget https://download.jetbrains.com/python/pycharm-community-${JETBRAINS_VERSION}.tar.gz
    tar -xzf pycharm-community-${JETBRAINS_VERSION}.tar.gz
    rm pycharm-community-${JETBRAINS_VERSION}.tar.gz
    mv pycharm-community-${JETBRAINS_VERSION} /opt/pycharm
}

INSTALL_RUBYMINE() {
    printf "${YELLOW}Installing RubyMine\n"
    wget https://download.jetbrains.com/ruby/RubyMine-${JETBRAINS_VERSION}.tar.gz
    tar -xzf RubyMine-${JETBRAINS_VERSION}.tar.gz
    rm RubyMine-${JETBRAINS_VERSION}.tar.gz
    mv RubyMine-${JETBRAINS_VERSION} /opt/rubymine
}

INSTALL_SUBLIME() {
    printf "${YELLOW}Installing Sublime Text\n"
    wget https://download.sublimetext.com/sublime-text_build-3126_amd64.deb
    sudo dpkg -i sublime-text_build-3126_amd64.deb
    rm sublime-text_build-3126_amd64.deb
}


INSTALL_INTELLIJ() {
    printf "${YELLOW}Installing IntelliJ\n"
    wget https://download.jetbrains.com/idea/ideaIU-${JETBRAINS_VERSION}.tar.gz
    tar -xzf ideaIU-${JETBRAINS_VERSION}.tar.gz
    rm ideaIU-${JETBRAINS_VERSION}.tar.gz
    mv idea-IU-${JETBRAINS_VERSION} /opt/intellij
}


INSTALL_GOLAND() {
    printf "${YELLOW}Installing Goland...${NC}\n"
    curl -fsSL https://download.jetbrains.com/go/goland-${JETBRAINS_VERSION}.tar.gz -o /tmp/goland.tar.gz
    tar -C /opt -xzf /tmp/goland.tar.gz
    rm /tmp/goland.tar.gz
}

INSTALL_VAGRANT() {
    printf "${YELLOW}Installing Vagrant...${NC}\n"
    curl -fsSL https://releases.hashicorp.com/vagrant/${VAGRANT_VERSION}/vagrant_${VAGRANT_VERSION}_x86_64.deb -o /tmp/vagrant.deb
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

INSTALL_NODEJS() {
    printf "${YELLOW}Installing NPM...${NC}\n"
    curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash -
    apt install nodejs
}

INSTALL_YARN() {
    printf "${YELLOW}Installing Yarn...${NC}\n"
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    apt update &&  apt install yarn
}

INSTALL_RUST() {
    printf "${YELLOW}Installing Rust...${NC}\n"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
}

INSTALL_NINJA() {
    printf "${YELLOW}Installing Ninja...${NC}\n"
    curl -fsSL https://github.com/ninja-build/ninja/releases/download/v1.10.2/ninja-linux.zip -o /tmp/ninja.zip
    unzip /tmp/ninja.zip -d /usr/local/bin/
    rm /tmp/ninja.zip
}

INSTALL_MESONBUILD() {
    printf "${YELLOW}Installing Meson...${NC}\n"
    git clone git clone https://github.com/mesonbuild/meson.git /usr/local/bin/
}

INSTALL_BOOSTLIB() {
    printf "${YELLOW}Installing Boost...${NC}\n"
    wget https://dl.bintray.com/boostorg/release/1.79.0/source/boost_1_79_0.tar.gz
    tar -xzf boost_1_79_0.tar.gz
    cd boost_1_79_0
    ./bootstrap.sh --prefix=/usr/local
    ./b2 install
    cd ..
    rm boost_1_79_0.tar.gz
}

INSTALL_VENV() {
    printf "${YELLOW}Installing virtualenv...${NC}\n"
    apt install python3-pip -y 
    pip3 install virtualenv 
}

INSTALL_ANACONDA() {
    printf "${YELLOW}Installing Anaconda...${NC}\n"
    wget https://repo.anaconda.com/archive/Anaconda3-2021.11-Linux-x86_64.sh
    bash Anaconda3-2021.11-Linux-x86_64.sh
    rm Anaconda3-2021.11-Linux-x86_64.sh
}

INSTALL_ADOPTOPENJDK(){
    printf "${YELLOW}Installing OpenJDK...${NC}\n"
    apt-get install -y wget apt-transport-https gnupg
    wget https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public
    gpg --no-default-keyring --keyring ./adoptopenjdk-keyring.gpg --import artifactory.gpg.public
    gpg --no-default-keyring --keyring ./adoptopenjdk-keyring.gpg --export --output adoptopenjdk-archive-keyring.gpg 
    mkdir -p /usr/share/keyrings
    mv adoptopenjdk-archive-keyring.gpg /usr/share/keyrings && chown root:root /usr/share/keyrings/adoptopenjdk-archive-keyring.gpg 
    rm adoptopenjdk-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/adoptopenjdk-archive-keyring.gpg] https://adoptopenjdk.jfrog.io/adoptopenjdk/deb bionic main" |  tee /etc/apt/sources.list.d/adoptopenjdk.list
    apt update
    apt-get install adoptopenjdk-11-hotspot -y
}

INSTALL_FFMPEG() {
    printf "${YELLOW}Installing FFMPEG...${NC}\n"
    apt-get install -y ffmpeg
}

INSTALL_TELEGRAM() {
    printf "${YELLOW}Installing Telegram...${NC}\n"
    apt-get install -y telegram-desktop
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
    printf "${BLUE}This script will install the following packages: ${NC}\n\n"
    printf "[ ${BLUE}${ESSENTIALS[*]}${NC} ]\n\n"
    printf "${BLUE}Would like to continue ? [y/n] ${NC}\n"
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
        printf "${RED}Next installation steps may NOT run, since install essentials did not work${NC}\n\n"
    fi

    while true; do
        printf "${BLUE}Type what you would like to install ${NC}\n\n"
        printf "[ ${BLUE}${PROGRAMS_ARR[*]}${NC} ]\n\n"
        read -r response
        if [  "${PROGRAMS[$response]}" != "" ]; then
            ${PROGRAMS[$response]}
            printf "${YELLOW}Installation of $response completed\n"
            PROGRAMS_ARR=("${PROGRAMS_ARR[@]/$response}")
        else 
            printf "${RED}Exiting without installing program${NC} [ $response ] \n"
            printf "${RED}--------------------------------------------------------${NC}\n"
            printf "${RED}Only available programs can be installed  ${NC}\n\n"
            printf "${YELLOW}--------------------------------------------------------${NC}\n\n"
            printf "${YELLOW}Available programs: ${NC}\n\n"
            printf "[ ${YELLOW}${PROGRAMS_ARR[*]}${NC} ]\n\n"
            printf "${YELLOW}If you would like to include a program, please create an issue or PR on: ${NC}\n\n"
            printf "${YELLOW}https://github.com/merkez/install-tools/issues/new\n${NC}\n"
            break
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
