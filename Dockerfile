FROM gradle:7.3.1-jdk17 AS builder
LABEL maintainer="Hdiv Security"

COPY --chown=gradle:gradle ./log4j-cve-2021-44228 /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle :malicious-server:bootJar --no-daemon

FROM openjdk:8u181-jdk-alpine

RUN mkdir /app
COPY --from=builder /home/gradle/src/malicious-server/build/libs/*.jar /app/malicious-server.jar

RUN mkdir -p /usr/local/tomcat/

WORKDIR /usr/local/tomcat

CMD echo "Hello!"
