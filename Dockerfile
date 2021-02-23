FROM ubuntu
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/London

#Apt update
RUN apt-get update -y

#Tzdata
RUN apt-get install -y tzdata
RUN ln -fs /usr/share/zoneinfo/Europe/London /etc/localtime
RUN dpkg-reconfigure --frontend noninteractive tzdata

#Dependencies
RUN apt-get update && apt-get install -y \
        openjdk-11-jdk-headless \
        git

#ENV variable, will tell Core that it's running inside of a Docker container
ENV DOCKER=YES

RUN mkdir -p /modules/
RUN mkdir -p /modulestorage/
RUN mkdir -p /moduleconfig/
RUN mkdir -p /config/
RUN mkdir -p /app/

#Port 5555 is only in use when the TCP module is installed.
EXPOSE 5555

#Copy in the Core jar
COPY ./Core-Docker.jar /app/Core-Docker.jar

#Copy in the entrypoint script
COPY ./entrypoint.sh /app/entrypoint.sh

#When we start the container we want to run the entrypoint.sh script
ENTRYPOINT ["/bin/bash", "/app/entrypoint.sh"]