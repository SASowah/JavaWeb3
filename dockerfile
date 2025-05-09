# Stage 1: Build the Java web app using Maven
FROM maven:3.9.5-eclipse-temurin-17 AS builder
WORKDIR /app
COPY . .
RUN mvn clean package

# Stage 2: Deploy the WAR file to Tomcat
FROM tomcat:9.0.104-jdk8-temurin-jammy
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
