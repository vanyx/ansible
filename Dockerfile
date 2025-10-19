FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    openssh-server sudo vim less curl python3 python3-apt \
    && mkdir /var/run/sshd

RUN useradd -m ansiblelab \
    && echo "ansiblelab:password" | chpasswd \
    && usermod -aG sudo ansiblelab \
    && echo "ansiblelab ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ansiblelab

RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config \
    && sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config

EXPOSE 22

CMD ["/usr/sbin/sshd","-D"]