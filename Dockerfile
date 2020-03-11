FROM nginx:stable

RUN apt-get update && apt-get install -y locales locales-all openssh-server
RUN groupadd sshgroup && useradd -ms /bin/bash -g sshgroup sshuser
RUN echo 'sshuser:passw0rd' | chpasswd

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

ARG home=/home/sshuser
RUN mkdir $home/.ssh
COPY id_rsa.pub $home/.ssh/authorized_keys
RUN chown sshuser:sshgroup $home/.ssh/authorized_keys && \
    chmod 600 $home/.ssh/authorized_keys

CMD service ssh start && nginx -g 'daemon off;'
