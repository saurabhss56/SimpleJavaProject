# Stage 1: Build the application using Maven
FROM maven:3.8.6-openjdk-11-slim AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the pom.xml and source code into the container
COPY pom.xml .
COPY src ./src

# Build the application
RUN mvn clean install -DskipTests

# Stage 2: Run the application
FROM openjdk:11-jre-slim

# Set the working directory for the runtime
WORKDIR /app

# Copy the built jar file from the build stage
COPY --from=build /app/target/SimpleJavaProject-1.0-SNAPSHOT.jar /app/app.jar

# Expose the port (if your Java app runs on a specific port)
EXPOSE 9090

# Command to run the application
ENTRYPOINT ["java", "-jar", "/app/app.jar"]

