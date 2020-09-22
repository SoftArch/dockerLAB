# Kudos to DOROWU for his amazing VNC 18.04 KDE image
FROM dorowu/ubuntu-desktop-lxde-vnc
LABEL maintainer "ahmet.kabaoglu@gmail.com"

# Let's start with some basic stuff.
RUN apt-get update -qq && apt-get install -qqy \
    apt-transport-https \
    ca-certificates \
    curl \
    lxc \
    iptables \
    software-properties-common \
    wget
    
# Install Docker from Docker Inc. repositories.
RUN curl -sSL https://get.docker.com/ | sh
RUN curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose


# Install Visual Studio Code
RUN wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
RUN apt update && apt install code

ENV OPENBOX_ARGS='--startup "service docker start"'
