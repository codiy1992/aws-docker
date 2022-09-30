FROM python:latest
USER root

RUN apt-get update

RUN apt-get install -y groff less vim git sudo dnsutils

# add work user
RUN mkdir /home/work

RUN useradd -d /home/work work

RUN echo 'work   ALL=(ALL)    NOPASSWD:ALL' >> /etc/sudoers

# Remove default python2, use python3 instead
RUN rm -fr /usr/bin/python
RUN ln -sf /usr/local/bin/python /usr/bin/python

# install pip3 and requirements
RUN wget https://bootstrap.pypa.io/get-pip.py

RUN python get-pip.py

RUN pip install awscli

RUN pip install ansible

RUN pip install boto3

# install session manager plugin
RUN arch=$(arch | sed s/aarch64/arm64/ | sed s/x86_64/64bit/) && \
    curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_${arch}/session-manager-plugin.deb" -o "session-manager-plugin.deb"
RUN dpkg -i session-manager-plugin.deb

# Install yarn
RUN curl -fsSL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install -y nodejs
RUN npm install -g yarn

# Vim Configuration
RUN wget -O /home/work/.vimrc https://raw.githubusercontent.com/amix/vimrc/master/vimrcs/basic.vim && \
    chown work.work /home/work/.vimrc

RUN mkdir -p /work

RUN chown -R work.work /home/work

USER work
WORKDIR /work
