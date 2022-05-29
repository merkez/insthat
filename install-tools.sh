#!/bin/bash 

## This script can be extended in time to include more tools to install if required

ESSENTIALS=(git vim zsh curl wget  tree htop build-essential cmake net-tools) 
PROGRAMS_ARR=(
 goland pycharm intellij rubymine 
 sublime vagrant go docker mongodb
 virtualbox nodejs yarn ninja 
 rust boostlib venv anaconda 
 adoptopenjdk ffmpeg webstorm
 qemu kafka gdb jdk
 telegram qemu pip)

declare -A PROGRAMS=(
    [goland]="INSTALL_GOLAND"
    [pycharm]="INSTALL_PYCHARM"
    [intellij]="INSTALL_INTELLIJ"
    [rubymine]="INSTALL_RUBYMINE"
    [sublime]="INSTALL_SUBLIME"
    [vagrant]="INSTALL_VAGRANT"
    [go]="INSTALL_GO"
    [docker]="INSTALL_DOCKER_ENGINE"
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
    [qemu]="INSTALL_QEMU"
    [mongodb]="INSTALL_MONGODB"
    [webstorm]="INSTALL_WEBSTORM"
    [kafka]="INSTALL_KAFKA"
    [jdk]="INSTALL_JDK"
    [gdb]="INSTALL_GDB"
    [pip]="INSTALL_PIP"
)

JETBRAINS_VERSION="2022.1"
VAGRANT_VERSION="2.2.19"
GO_VERSION="1.18"
SUBLIME_VERSION="build-3126"


BLUE="\033[0;34m"
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
NC="\033[0m" 

INSTALL_GO() {
   printf "${YELLOW}Installing Go ${GO_VERSION}\n"
   curl  --no-progress-meter -fsSL https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz -o /tmp/go.tar.gz
   tar -C /usr/local -xzf /tmp/go.tar.gz
   rm /tmp/go.tar.gz
   printf "${RED}DO NOT FORGET TO ADD go to path...\n"
   printf "${RED}hint: export PATH=$PATH:/usr/local/go/bin  >> /home/$USER/.bashrc${NC}\n" 
}

INSTALL_PYCHARM() {
    printf "${YELLOW}Installing PyCharm\n"
    {
        curl  --no-progress-meter -fsSL https://download.jetbrains.com/python/pycharm-community-${JETBRAINS_VERSION}.tar.gz -o /tmp/pycharm.tar.gz
    } || {
        printf "${YELLOW} curl is not installed, installing curl\n${NC}"
        apt install -y curl
        curl --no-progress-meter -fsSL https://download.jetbrains.com/python/pycharm-community-${JETBRAINS_VERSION}.tar.gz -o /tmp/pycharm.tar.gz
    }

    tar -C /opt -xzf /tmp/pycharm.tar.gz
    rm /tmp/pycharm.tar.gz
    ln -s /opt/pycharm-community-${JETBRAINS_VERSION} /opt/pycharm
    echo "[Desktop Entry]
            Name=PyCharm
            Comment=PyCharm Community Edition
            Exec=/opt/pycharm/bin/pycharm.sh
            Icon=/opt/pycharm/bin/pycharm.png
            Terminal=false
            Type=Application
            Categories=Development;IDE;
            " > /usr/share/applications/pycharm.desktop

    chmod +x /usr/share/applications/pycharm.desktop
   {
       printf "${YELLOW}Installing WebStorm desktop shortcut...${NC}\n"
       desktop-file-install /usr/share/applications/pycharm.desktop
   } || {
        printf "${YELLOW}desktop-file-install command cannot be found, continuing...${NC}\n"
   }
   printf "${YELLOW} Cleaning up...${NC}\n"
   rm -rf /tmp/pycharm.tar.gz
   printf "${GREEN}PyCharm installed successfully!${NC}\n"
}

INSTALL_RUBYMINE() {
    printf "${YELLOW}Installing RubyMine\n"

     
    {
        curl  --no-progress-meter -fsSL https://download.jetbrains.com/ruby/RubyMine-${JETBRAINS_VERSION}.tar.gz -o /tmp/rubymine.tar.gz
    } || {
        printf "${YELLOW} curl is not installed, installing curl\n${NC}"
        apt install -y curl
        printf "${YELLOW} downloading rubymine...${NC}\n"
        curl --no-progress-meter -fsSL https://download.jetbrains.com/ruby/RubyMine-${JETBRAINS_VERSION}.tar.gz -o /tmp/rubymine.tar.gz
    }

    tar -C /opt -xzf /tmp/rubymine.tar.gz
    ln -s /opt/RubyMine-${JETBRAINS_VERSION} /opt/rubymine
    rm /tmp/rubymine.tar.gz
    echo "[Desktop Entry]
            Name=RubyMine
            Comment=RubyMine Community Edition
            Exec=/opt/rubymine/bin/rubymine.sh
            Icon=/opt/rubymine/bin/rubymine.png
            Terminal=false
            Type=Application
            Categories=Development;IDE;
            " > /usr/share/applications/rubymine.desktop

    chmod +x /usr/share/applications/rubymine.desktop
    {
        printf "${YELLOW}Installing WebStorm desktop shortcut...${NC}\n"
        desktop-file-install /usr/share/applications/rubymine.desktop
       
    } ||
    {
        printf "${YELLOW}desktop-file-install command cannot be found, continuing...${NC}\n"
    }
    printf "${YELLOW} Cleaning up...${NC}\n"
    rm -rf /tmp/rubymine.tar.gz
    printf "${GREEN}RubyMine installed successfully!${NC}\n"

   
}


INSTALL_INTELLIJ() {
    printf "${YELLOW}Installing IntelliJ\n"

    {
        curl  --no-progress-meter -fsSL https://download.jetbrains.com/idea/ideaIC-${JETBRAINS_VERSION}.tar.gz -o /tmp/intellij.tar.gz
    } || {
        printf "${YELLOW} curl is not installed, installing curl\n${NC}"
        apt install -y curl
        printf "${YELLOW} Downloading intellij idea...${NC}\n"
        curl --no-progress-meter -fsSL https://download.jetbrains.com/idea/ideaIC-${JETBRAINS_VERSION}.tar.gz -o /tmp/intellij.tar.gz
    }

    tar -C /opt -xzf /tmp/intellij.tar.gz
    ln -s /opt/ideaIC-${JETBRAINS_VERSION} /opt/intellij
    echo "[Desktop Entry]
            Name=IntelliJ
            Comment=IntelliJ Community Edition
            Exec=/opt/intellij/bin/idea.sh
            Icon=/opt/intellij/bin/idea.png
            Terminal=false
            Type=Application
            Categories=Development;IDE;
            " > /usr/share/applications/intellij.desktop

    chmod +x /usr/share/applications/intellij.desktop
    {
        printf "${YELLOW}Installing WebStorm desktop shortcut...${NC}\n"
        desktop-file-install /usr/share/applications/intellij.desktop
    } ||
    {
        printf "${YELLOW}desktop-file-install command cannot be found, continuing...${NC}\n"
    }
    printf "${YELLOW} Cleaning up...${NC}\n"
    rm -rf /tmp/intellij.tar.gz
    printf "${GREEN}IntelliJ installed successfully!${NC}\n"
}

INSTALL_GOLAND() {
    printf "${YELLOW}Installing Goland...${NC}\n"
    
    {
        curl  --no-progress-meter -fsSL https://download.jetbrains.com/go/goland-${JETBRAINS_VERSION}.tar.gz -o /tmp/goland.tar.gz
    } || {
        printf "${YELLOW} curl is not installed, installing curl\n${NC}"
        apt install -y curl
        printf "${YELLOW} Downloading goland...${NC}\n"
        curl --no-progress-meter -fsSL https://download.jetbrains.com/go/goland-${JETBRAINS_VERSION}.tar.gz -o /tmp/goland.tar.gz
    }

    tar -C /opt -xzf /tmp/goland.tar.gz
    ln -s /opt/goland-${JETBRAINS_VERSION} /opt/goland

    echo "[Desktop Entry]
            Name=Goland
            Comment=Goland Community Edition
            Exec=/opt/goland/bin/goland.sh
            Icon=/opt/goland/bin/goland.png
            Terminal=false
            Type=Application
            Categories=Development;IDE;
            " > /usr/share/applications/goland.desktop

    chmod +x /usr/share/applications/goland.desktop
    {
        printf "${YELLOW}Installing WebStorm desktop shortcut...${NC}\n"
        desktop-file-install /usr/share/applications/goland.desktop
    } ||
    {
        printf "${YELLOW}desktop-file-install command cannot be found, continuing...${NC}\n"
    }
    printf "${YELLOW} Cleaning up...${NC}\n"
    rm -rf /tmp/goland.tar.gz
    printf "${GREEN}Goland installed successfully!${NC}\n"
}




INSTALL_SUBLIME() {
    {
        printf "${YELLOW} Downloading sublime text...${NC}\n"
        curl  --no-progress-meter -fsSL https://download.sublimetext.com/sublime-text_${SUBLIME_VERSION}_amd64.deb -o /tmp/sublime.deb
    }|| {
        printf "${YELLOW} curl is not installed, installing curl\n${NC}"
        apt install -y curl
       
        curl --no-progress-meter -fsSL https://download.sublimetext.com/sublime-text_${SUBLIME_VERSION}_amd64.deb -o /tmp/sublime.deb
    }

    {
        printf "${YELLOW} Installing sublime text...${NC}\n"
        dpkg -i /tmp/sublime.deb
        printf "${GREEN}Sublime installed successfully!${NC}\n"
    }||{
        printf "${YELLOW} sublime could not be installed, manual check might require\n${NC}"
        exit 1
    }
    printf "${YELLOW} Cleaning up...${NC}\n"
    rm /tmp/sublime.deb
}






INSTALL_VAGRANT() {
    printf "${YELLOW}Installing Vagrant...${NC}\n"
    {
        printf "${YELLOW} Downloading Vagrant...${NC}\n"
        curl  --no-progress-meter -fsSL https://releases.hashicorp.com/vagrant/${VAGRANT_VERSION}/vagrant_${VAGRANT_VERSION}_x86_64.deb -o /tmp/vagrant.deb

    }|| {
        printf "${YELLOW} curl is not installed, installing curl\n${NC}"
        apt install -y curl
        printf "${YELLOW} Downloading Vagrant...${NC}\n"
        curl --no-progress-meter -fsSL https://releases.hashicorp.com/vagrant/${VAGRANT_VERSION}/vagrant_${VAGRANT_VERSION}_x86_64.deb -o /tmp/vagrant.deb
    }

    {
        printf "${YELLOW} Installing Vagrant...${NC}\n"
        dpkg -i /tmp/vagrant.deb
        printf "${GREEN}Vagrant installed successfully!${NC}\n"
    }|| {
        printf "${YELLOW} Vagrant could not be installed, manual check might require\n${NC}"
        exit 1
    }

}

INSTALL_QEMU() {
    printf "${YELLOW}Installing QEMU...${NC}\n"
    printf "${YELLOW} While installing QEMU, some other packages will be installed as well...${NC}\n"
    printf "${YELLOW} Please wait...${NC}\n"
    {
        apt install qemu qemu-kvm qemu-utils -y
    }||
    {
        printf "${YELLOW}qemu cannot be installed through apt try to install from source by uncommenting uninstallation steps below${NC}\n"
        # Installation from git source code, in case required
        # git clone https://gitlab.com/qemu-project/qemu.git /temp/qemu
        # cd /temp/qemu
        # git submodule init
        # git submodule update --recursive
        # ./configure
        # make
        # rm -rf /temp/qemu
    }

}

INSTALL_DOCKER_ENGINE() {
    printf "${YELLOW}Installing Docker...${NC}\n"
    curl  --no-progress-meter  -fsSL https://get.docker.com -o get-docker.sh
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
    printf "${YELLOW}Installing VirtualBox Dependencies...${NC}\n"
    # required dependencies for VirtualBox
    apt-get install acpica-tools chrpath doxygen g++-multilib libasound2-dev libcap-dev \
        libcurl4-openssl-dev libdevmapper-dev libidl-dev libopus-dev libpam0g-dev \
        libpulse-dev libqt5opengl5-dev libqt5x11extras5-dev qttools5-dev libsdl1.2-dev libsdl-ttf2.0-dev \
        libssl-dev libvpx-dev libxcursor-dev libxinerama-dev libxml2-dev libxml2-utils \
        libxmu-dev libxrandr-dev make nasm python3-dev python-dev qttools5-dev-tools \
        texlive texlive-fonts-extra texlive-latex-extra unzip xsltproc \
        \
        default-jdk libstdc++5 libxslt1-dev linux-kernel-headers makeself \
        mesa-common-dev subversion yasm zlib1g-dev -y

    # additional dependencies
    apt-get install ia32-libs libc6-dev-i386 lib32gcc1 lib32stdc++6 -y
    printf "${YELLOW}Downloading VirtualBox DEB file...${NC}\n"
    curl  --no-progress-meter  -fsSL https://download.virtualbox.org/virtualbox/6.1.34/virtualbox-6.1_6.1.34-150636.1~Ubuntu~bionic_amd64.deb -o /tmp/virtualbox.deb
    printf "${YELLOW}Installing VirtualBox ...${NC}\n"
    dpkg -i /tmp/virtualbox.deb
    rm /tmp/virtualbox.deb
}

INSTALL_NODEJS() {
    printf "${YELLOW}Installing NPM...${NC}\n"
    curl  --no-progress-meter  -sL https://deb.nodesource.com/setup_18.x | sudo -E bash -
    apt install nodejs
}

INSTALL_YARN() {
    printf "${YELLOW}Installing Yarn...${NC}\n"
    curl  --no-progress-meter -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    apt update &&  apt install yarn
}

INSTALL_RUST() {
    printf "${YELLOW}Installing Rust...${NC}\n"
    curl  --no-progress-meter --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
}

INSTALL_NINJA() {
    printf "${YELLOW}Installing Ninja...${NC}\n"
    curl  --no-progress-meter -fsSL https://github.com/ninja-build/ninja/releases/download/v1.10.2/ninja-linux.zip -o /tmp/ninja.zip
    unzip /tmp/ninja.zip -d /usr/local/bin/
    rm /tmp/ninja.zip
}

INSTALL_MESONBUILD() {
    printf "${YELLOW}Installing Meson...${NC}\n"
    git clone git clone https://github.com/mesonbuild/meson.git /usr/local/bin/
}

INSTALL_BOOSTLIB() {
    printf "${YELLOW}Installing Boost...${NC}\n"

    {   
        printf "${YELLOW}Downloading Boost 1.79...${NC}\n"
        curl  --no-progress-meter -fsSL https://dl.bintray.com/boostorg/release/1.79.0/source/boost_1_79_0.tar.gz -o /tmp/boost.tar.gz
    } || {
        printf "${YELLOW}curl cannot be found installing curl .${NC}\n"
        apt install curl -y
        curl  --no-progress-meter -fsSL https://dl.bintray.com/boostorg/release/1.73.0/source/boost_1_73_0.tar.gz -o /tmp/boost.tar.gz
    }

    printf "${YELLOW}Extracting Boost...${NC}\n"
    tar -xzf /tmp/boost.tar.gz -C /usr/local/
    
    cd /usr/local/boost_1_79_0/
    printf "${YELLOW}Building Boost...${NC}\n"
    ./bootstrap.sh --prefix=/usr/local/boost
    printf "${YELLOW}Installing Boost...${NC}\n"
    ./b2 install
    printf "${YELLOW}Cleaning up ...${NC}\n"
    rm /tmp/boost.tar.gz
    printf "${GREEN}Boost installed successfully!${NC}\n"
}

INSTALL_VENV() {
    printf "${YELLOW}Installing virtualenv...${NC}\n"
    apt install python3-pip -y 
    pip3 install virtualenv 
}

INSTALL_ANACONDA() {

    {
        printf "${YELLOW}Downloading Anaconda script...${NC}\n"
        curl  --no-progress-meter -fsSL https://repo.anaconda.com/archive/Anaconda3-2021.11-Linux-x86_64.sh -o /tmp/anaconda.sh
       

    } || {
        printf "${YELLOW}curl cannot be found installing curl .${NC}\n"
        apt install curl -y
        curl  --no-progress-meter -fsSL https://repo.anaconda.com/archive/Anaconda3-2021.11-Linux-x86_64.sh -o /tmp/anaconda.sh
    }
    
    {    
 
        printf "${YELLOW}Installing Anaconda...${NC}\n"
        bash /tmp/anaconda.sh -b -p /usr/local/anaconda3
        printf "${GREEN}Anaconda installed successfully!${NC}\n"
    } || {
        printf "${RED}There is an error with installing anaconda .${NC}\n"
        printf "${RED}Check manually...${NC}\n"
        exit 1
    }
   
}

INSTALL_ADOPTOPENJDK(){
    printf "${YELLOW}Installing OpenJDK...${NC}\n"
    apt  install -y -q apt-transport-https gnupg
    {
        curl  --no-progress-meter -fsSL https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public 
    } || {
        printf "${YELLOW}curl cannot be found installing curl .${NC}\n"
        apt install curl -y
        curl  --no-progress-meter -fsSL https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public
    }
   
    gpg --no-default-keyring --keyring ./adoptopenjdk-keyring.gpg --import artifactory.gpg.public
    gpg --no-default-keyring --keyring ./adoptopenjdk-keyring.gpg --export --output adoptopenjdk-archive-keyring.gpg 
    mkdir -p /usr/share/keyrings
    mv adoptopenjdk-archive-keyring.gpg /usr/share/keyrings && chown root:root /usr/share/keyrings/adoptopenjdk-archive-keyring.gpg 
    rm adoptopenjdk-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/adoptopenjdk-archive-keyring.gpg] https://adoptopenjdk.jfrog.io/adoptopenjdk/deb bionic main" |  tee /etc/apt/sources.list.d/adoptopenjdk.list
    apt update
    apt install adoptopenjdk-11-hotspot -y
}

INSTALL_FFMPEG() {
    printf "${YELLOW}Installing FFMPEG...${NC}\n"
    apt install -y ffmpeg
}

INSTALL_TELEGRAM() {
    printf "${YELLOW}Installing Telegram...${NC}\n"
    apt install -y telegram-desktop
}


INSTALL_MONGODB() {
    

    {   
        printf "${YELLOW}Adding MongoDB public keys...${NC}\n"
        curl  --no-progress-meter -fsSL  https://www.mongodb.org/static/pgp/server-5.0.asc |  apt-key add -

    } || {

        printf "${YELLOW}curl cannot be found installing curl .${NC}\n"
        apt install curl -y
        curl  --no-progress-meter -fsSL  https://www.mongodb.org/static/pgp/server-5.0.asc |  apt-key add -
    }
   
    touch /etc/apt/sources.list.d/mongodb-org-5.0.list
    echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0 multiverse" |  tee /etc/apt/sources.list.d/mongodb-org-5.0.list
    apt update
    printf "${YELLOW}Installing MongoDB...${NC}\n"
    apt install -y mongodb-org

    {
        printf "${YELLOW}Starting MongoDB...${NC}\n"
        systemctl start mongod

    } || {
        printf "${YELLOW}Reloading system daemon...${NC}\n"
        systemctl daemon-reload
    } 
    
    systemctl enable mongod

    {
        printf "${YELLOW}Checking MongoDB version...${NC}\n"
        mongod --version
    } || {
        printf "${YELLOW}There is an issue while checking version of mongodb...${NC}\n"
        printf "${YELLOW}Please check manually...${NC}\n"
        exit 1
    }

}

INSTALL_WEBSTORM() {
    printf "${YELLOW}Installing WebStorm...${NC}\n"
    {
      curl  --no-progress-meter -fsSL https://download-cdn.jetbrains.com/webstorm/WebStorm-${JETBRAINS_VERSION}.tar.gz -o /tmp/webstorm.tar.gz
    } || {
        printf "${YELLOW}curl tool cannot be found, installing it to continue with process ${NC}\n"
        apt install curl -y
        printf "${YELLOW}Downloading WebStorm...${NC}\n"
        curl  --no-progress-meter -fsSL https://download-cdn.jetbrains.com/webstorm/WebStorm-${JETBRAINS_VERSION}.tar.gz -o /tmp/webstorm.tar.gz
    }
    
    printf "${YELLOW}Extracting  WebStorm to /opt/ ${NC}\n"
    tar -xzf /tmp/webstorm.tar.gz -C /opt
    printf "${YELLOW}Creating symbolic link...${NC}\n"
    ln -s /opt/WebStorm-${JETBRAINS_VERSION} /opt/WebStorm
    printf "${YELLOW}Creating WebStorm launcher...${NC}\n"
    echo "[Desktop Entry]
            Name=WebStorm
            Comment=WebStorm IDE
            Exec=/opt/webstorm/bin/webstorm.sh
            Icon=/opt/webstorm/bin/webstorm.png
            Terminal=false
            Type=Application
            Categories=Development;IDE;
            " > /usr/share/applications/webstorm.desktop

    printf "${YELLOW}Installing WebStorm launcher...${NC}\n"
    chmod +x /usr/share/applications/webstorm.desktop
    printf "${YELLOW}Installing WebStorm icon...${NC}\n"
    cp /opt/webstorm/bin/webstorm.png /usr/share/icons/hicolor/256x256/apps/
    {
        printf "${YELLOW}Installing WebStorm desktop shortcut...${NC}\n"
        desktop-file-install /usr/share/applications/webstorm.desktop

    } || {
        printf "${YELLOW}desktop-file-install command cannot be found, continuing...${NC}\n"
    }
   
    printf "${YELLOW}Cleaning up...${NC}\n"
    rm -rf WebStorm-${JETBRAINS_VERSION}.tar.gz
 
}

INSTALL_GDB() {
    printf "${YELLOW}Installing GDB...${NC}\n"
    apt install -y gdb
    printf "${GREEN} GDB installed successfully ${NC}\n"
}

INSTALL_JDK (){
    printf "${YELLOW}Installing JDK...${NC}\n"

    apt install -y openjdk-11-jdk
}

INSTALL_KAFKA (){
    # installation of kafka requires jdk to be installed

    printf "${YELLOW}Installing Kafka...${NC}\n"
    {
        curl  --no-progress-meter -fsSL https://dlcdn.apache.org/kafka/3.2.0/kafka_2.13-3.2.0.tgz -o /tmp/kafka.tgz
    } || {
        printf "${YELLOW}curl tool cannot be found, installing it to continue with process ${NC}\n"
        apt install curl -y
        printf "${YELLOW}Downloading Kafka...${NC}\n"
        curl  --no-progress-meter -fsSL https://dlcdn.apache.org/kafka/3.2.0/kafka_2.13-3.2.0.tgz -o /tmp/kafka.tgz
    }
    printf "${YELLOW}Extracting Kafka to /opt/ ${NC}\n"
    tar -xzf /tmp/kafka.tgz -C /opt
    printf "${YELLOW}Creating symbolic link...${NC}\n"
    ln -s /opt/kafka_2.13-3.2.0 /opt/kafka
    printf "${GREEN}Kafka is installeed to /opt/kafka ${NC}\n"
}

INSTALL_PIP() {
    printf "${YELLOW}Installing pip...${NC}\n"
    { 
        printf "${YELLOW}Installing pip through apt ...${NC}\n"
        apt install -y python3-pip
    } || {
        printf "${YELLOW}Installing pip through get-pip.py ...${NC}\n"
        curl  --no-progress-meter -fsSL https://bootstrap.pypa.io/get-pip.py -o /tmp/get-pip.py
        {
            python /tmp/get-pip.py
        } || {
            python3 /tmp/get-pip.py
        }
    }
}

INSTALL_ESSENTIALS() {
     for i in "${ESSENTIALS[@]}" ; do
        printf "\n${BLUE}Installing  $i ${NC}\n"
        printf "${BLUE}********************************************************${NC}\n"
        apt install -y $i
    done
}

## INSTALL_PROGRAMS FOR TEST PURPOSES
INSTALL_PROGRAMS() {
    for i in "${PROGRAMS_ARR[@]}" ; do
        printf "\n${BLUE}Installing  $i ${NC}\n"
        printf "${BLUE}********************************************************${NC}\n"
        ${PROGRAMS[$i]}
    done
}

TEST_RANDOMLY() {
    printf "\n${BLUE}Testing installation process randomly...${NC}\n"
    printf "${BLUE}********************************************************${NC}\n"
    len=${#PROGRAMS[@]}
    for i in {0..7} ; do
        index=$(( $RANDOM % $len + 1 ))
        prg=${PROGRAMS_ARR[$index]}
        printf "\n${BLUE}Installing  $prg ${NC}\n"
        ${PROGRAMS[$prg]}
    done
    printf "\n${BLUE}********************************************************${NC}\n"
    printf "\n${BLUE}Testing process finished...${NC}\n"
}

  #  this is for test purposes on CI
if [[ $1 == "-t" || $1 == "--testall" ]]; then
    printf "${YELLOW}TEST MODE: TESTING INSTALLATION FUNCTIONS${NC}\n"
    INSTALL_ESSENTIALS
    INSTALL_PROGRAMS
    exit 0
elif [[ $1 == "-r" || $1 == "--random" ]]; then
    INSTALL_ESSENTIALS
    TEST_RANDOMLY
    exit 0
else # this is for normal installation              
    if [[ $EUID -ne 0 ]]; then  
        printf "${RED}This script must be run as root\n" 
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
            INSTALL_ESSENTIALS
        else 
            printf "${RED}Exiting without installing essentials \n"
            printf "${RED}--------------------------------------------------------${NC}\n"
            printf "${RED}Next installation steps may NOT run, since install essentials did not work${NC}\n\n"
        fi

        while true; do
            printf "\n${BLUE}Type what you would like to install ${NC}\n\n"
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
fi
