FROM louislam/uptime-kuma:1.21.2 as runtime

WORKDIR /app

COPY ./config/init.sh .
COPY ./config/sshd_config /etc/ssh/

# Start and enable SSH
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends dialog \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends openssh-server \
    && echo "root:Docker!" | chpasswd \
    && chmod u+x init.sh

# Open port 2222 for SSH access
EXPOSE 2222

CMD ["sh", "init.sh"]
