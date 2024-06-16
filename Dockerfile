## Use an official OpenJDK runtime as a parent image
#FROM openjdk:17-jdk-alpine
#
## Set the working directory in the container
#WORKDIR /app
#
## Copy the built JAR file into the container
#COPY target/spring-api-docker-0.0.1-SNAPSHOT.jar /app/spring-api-docker.jar
#
## Make port 8086 available to the world outside this container
#EXPOSE 8086
#
## Run the JAR file
#ENTRYPOINT ["java", "-jar", "/app/spring-api-docker.jar"]







#
FROM openjdk:17

# Expose the port the application will run on
EXPOSE 8086

# Argument for the JAR file
ARG JAR_FILE=target/*.jar

# Copy the JAR file into the container
COPY ${JAR_FILE} /spring-api-docker.jar

# Run the JAR file
ENTRYPOINT ["java", "-jar", "/spring-api-docker.jar"]














#
#FROM openjdk:17
## RUN  apk add --no-cache tzdata ttf-dejavu && ln -sf /usr/share/zoneinfo/Africa/Nairobi /etc/localtime  && echo "Africa/Nairobi" > /etc/timezone
## Add a volume pointing to /tmp
##VOLUME /tmp
## Make port 8087 available to the world outside this container
#EXPOSE 8086
##The fLat File
#ARG JAR_FILE=*.jar
#
##Add applications'jar to the container
#ADD ${JAR_FILE} spring-api-docker.jar
#
#RUN mkdir -p /spring-api-docker-app
#
##run the jar file
#ENTRYPOINT ["java","-jar","/spring-api-docker.jar"]












#FROM openjdk:17
#EXPOSE:8086
#ADD target/spring-api-docker.jar spring-api-docker.jar
#ENTRYPOINT ["java","-jar","/spring-api-docker.jar"]

## Use an official OpenJDK runtime as a parent image
#FROM openjdk:17-jdk-alpine
#
## Set the working directory in the container
#WORKDIR /app
#
## Copy the packaged jar file into the container at /app
#COPY target/spring-api-docker.jar /app
#
## Make port 8080 available to the world outside this container
#EXPOSE 8086
#
## Define environment variable
#ENV JAVA_OPTS=""
#
## Run the jar file
#ENTRYPOINT ["java","-jar","spring-api-docker.jar"]
