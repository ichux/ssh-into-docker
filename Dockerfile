FROM nginx:stable

RUN ["apt-get", "update"]
RUN ["apt-get", "install", "-y", "openssh-server"]
RUN mkdir /var/run/sshd
RUN echo 'root:passw0rd' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN ["/etc/init.d/ssh", "start"]

EXPOSE 22
WORKDIR "/app"
CMD /usr/sbin/sshd -D && nginx -g 'daemon off;'
