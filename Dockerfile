FROM alpine

RUN apk add --no-cache \
    openssh

RUN ssh-keygen -A

ARG SSH_USER=ssh

RUN sed -i 's/#\?\(#PermitRootLogin\s*\).*$/\1 no/' /etc/ssh/sshd_config && \
    sed -i 's/#\?\(PasswordAuthentication\s*\).*$/\1 no/' /etc/ssh/sshd_config && \
    sed -i 's/#\?\(AllowTcpForwarding\s*\).*$/\1 no/' /etc/ssh/sshd_config && \
    sed -i 's/#\?\(PermitTTY\s*\).*$/\1 no/' /etc/ssh/sshd_config && \
    sed -i 's/#\?\(X11Forwarding\s*\).*$/\1 no/' /etc/ssh/sshd_config && \
    sed -i 's/#\?\(PermitTunnel\s*\).*$/\1 no/' /etc/ssh/sshd_config && \
    sed -i 's/#\?\(GatewayPorts\s*\).*$/\1 no/' /etc/ssh/sshd_config 

# Add ssh user and config to restrict access
COPY ./user-sshdconfig user-sshdconfig
RUN addgroup -g 1000 ${SSH_USER} && \
    adduser -u 1000 -G ${SSH_USER} -h /home/${SSH_USER} -s /bin/sh -D ${SSH_USER} && \
    echo ${SSH_USER}:${SSH_USER} | chpasswd && \
    sed -i "s/Match User ssh/Match User ${SSH_USER}/" ./user-sshdconfig && \
    cat user-sshdconfig >> /etc/ssh/sshd_config && \
    rm user-sshdconfig

CMD [ "/usr/sbin/sshd", "-D"]

