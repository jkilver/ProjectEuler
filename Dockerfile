FROM ubuntu:16.04

WORKDIR /root

# Install all the things
RUN apt-get update \
    # What does this do?
    && apt-get install -y software-properties-common \
    && add-apt-repository ppa:jonathonf/python-3.6 \
    && apt-get -y update \
    && apt-get -y dist-upgrade \
    && apt-get -y --force-yes install \
        curl \
        git \
        gcc \
        g++ \
        libboost-all-dev \
        build-essential python3.6 python3.6-dev python3-pip python3.6-venv \
    # Cleanup
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Make python 3.6 default 
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.6 1 \
    && python -m pip install pip --upgrade 

# Create temp user (changes to actual user if build on Linux system) and give sudo permissions
# Make a home directory, create user testuser
ARG UID=1000
ARG GID=1000
ARG UNAME=testuser

# Create identical user in docker container, give sudo permission
RUN whoami
RUN mkdir -p /home/${UNAME}
RUN echo "${UNAME}:x:${UID}:${GID}:${UNAME},,,:/home/${UNAME}:/bin/bash" >> /etc/passwd
RUN echo "${UNAME}:x:${UID}:" >> /etc/group
RUN echo "${UNAME} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${UNAME}
RUN chmod 0440 /etc/sudoers.d/${UNAME}
RUN chown ${UID}:${GID} -R /home/${UNAME}

# Set up home environment
USER ${UNAME}
ENV HOME /home/${UNAME}

WORKDIR ${HOME}

# Install pip requirements, set python paths
COPY requirements.txt /home/${UNAME}/requirements.txt
ENV PATH "$PATH:${HOME}/.local/bin"
ENV PYTHONPATH "$PYTHONPATH:${HOME}/.local/lib/python3.6/site-packages:${HOME}/.local/bin"
RUN python3.6 -m pip install pip --upgrade \ 
    && python3.6 -m pip install --user -r ${HOME}/requirements.txt

ENTRYPOINT /bin/bash
