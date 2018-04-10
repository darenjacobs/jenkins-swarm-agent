FROM openjdk:8-jdk-alpine

ENV SWARM_CLIENT_VERSION="3.9" \
    DOCKER_COMPOSE_VERSION="1.19.0" \
    COMMAND_OPTIONS="" \
    USER_NAME_SECRET="" \
    PASSWORD_SECRET=""

RUN adduser -G root -D jenkins && \
    apk --update --no-cache add maven nodejs nodejs-npm git python py-pip openssh ca-certificates openssl && \
    wget -q https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/${SWARM_CLIENT_VERSION}/swarm-client-${SWARM_CLIENT_VERSION}.jar -P /home/jenkins/ && \
    pip install --upgrade pip && \
    pip install docker-compose

COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/bin/sh", "/run.sh"]
