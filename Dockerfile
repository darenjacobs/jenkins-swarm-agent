# Image installs with latest Java 8 OpenJDK on Alpine Linux
FROM openjdk:8-jdk-alpine

USER root

ENV SWARM_CLIENT_VERSION="3.9" \
    COMMAND_OPTIONS=""

# Update and upgrade apk then install curl, maven, git, and nodejs
RUN adduser -G root -D jenkins && \
  apk update && \
	apk upgrade && \
	apk --no-cache add curl && \
	apk --no-cache add wget && \
	apk --no-cache add maven && \
	apk --no-cache add git && \
	apk --no-cache add docker


# Download the latest Jenkins swarm client with curl - version 3.3
# Browse all versions here: https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/
RUN wget https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/${SWARM_CLIENT_VERSION}/swarm-client-${SWARM_CLIENT_VERSION}.jar -P /home/jenkins/
ADD run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/bin/sh", "/run.sh"]
