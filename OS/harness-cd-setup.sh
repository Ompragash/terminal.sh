#!/bin/bash

check_git() {
    if [ -x "$(command -v git)" ]; then
        return 0
    else
        echo "Error: git is not installed. This script requires git to clone Harness CD Community repo."
        echo "Install git and rerun the script."
        return 1
    fi
}

install_docker_fedora() {
    # Install and Enable Docker on Fedora distribution
    dnf -y install dnf-plugins-core
    dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
    dnf -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin
    systemctl enable docker; systemctl start docker
}

install_docker_centos() {
    # Install and Enable Docker on CentOS, AlmaLinux, and RockyLinux distributions
    dnf -y install yum-utils
    dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    dnf -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin
    systemctl enable docker; systemctl start docker
}

install_docker_ubuntu() {
    # Install and Enable Docker on Ubuntu-based distributions
    apt-get update
    apt-get install ca-certificates curl gnupg lsb-release -y
    mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    echo   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
    chmod a+r /etc/apt/keyrings/docker.gpg
    apt-get update
    apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
    systemctl enable docker; systemctl start docker
}

install_docker_debian() {
    # Install and Enable Docker on Debian-based distributions
    apt-get update
    apt-get install ca-certificates curl gnupg lsb-release -y
    mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
    $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
    chmod a+r /etc/apt/keyrings/docker.gpg
    apt-get update
    apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
    systemctl enable docker; systemctl start docker
}


install_docker() {
    # Check the Linux distribution
    if [ -f /etc/redhat-release ]; then
        # Red Hat-based distribution
        install_docker_centos
    elif [ -f /etc/fedora-release ]; then
        # Fedora distribution
        install_docker_fedora
    elif [ -f /etc/lsb-release ]; then
        # Ubuntu-based distribution
        install_docker_ubuntu
    elif [ -f /etc/debian_version ]; then
        # Debian-based distribution
        install_docker_debian
    else
        echo "Error: Docker is not installed."
        return 1
    fi
}

check_docker() {
    if [ -x "$(command -v docker)" ]; then
        git clone https://tiny.one/harness-cd-community
        echo "Pulling below docker images mentioned in the docker-compose.yml file..."
        docker compose -f harness-cd-community/docker-compose/harness/docker-compose.yml config | grep 'image:' | awk '{print $2}'
        docker compose -f harness-cd-community/docker-compose/harness/docker-compose.yml pull > /dev/null
        export HARNESS_HOST="$(hostname -i)"
        docker compose -f harness-cd-community/docker-compose/harness/docker-compose.yml up -d
        echo "Access the deployed Harness CD Community using link http://$(hostname -i)/#/signup"
        return 0
    else
        if ! install_docker; then
            exit 1
        fi
    fi
}

if ! check_git; then
    exit 1
else
    check_docker
fi

