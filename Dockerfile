FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    openssh-server sudo vim less curl python3 \
    && mkdir /var/run/sshd

RUN useradd -m ansiblelab \
    && echo "ansiblelab:password" | chpasswd \
    && usermod -aG sudo ansiblelab

RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config \
    && sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config

EXPOSE 22

# lance le serveur SSH
CMD ["/usr/sbin/sshd","-D"]
