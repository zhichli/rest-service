# Use an official OpenJDK runtime as a parent image suitable for Java 17
FROM openjdk:17-jdk

# Set the working directory in the container
WORKDIR /app

# Copy the Maven Wrapper and pom.xml to the container
COPY mvnw .
COPY pom.xml ./

# Copy the project source to the container
COPY src ./src

# Make the mvnw file executable
RUN chmod +x mvnw

# Verify the installed Java version
RUN java -version

# Package the application code
RUN ./mvnw package -DskipTests

# Move the built application to the app directory (assuming a typical target directory structure)
RUN mv target/*.jar app.jar

# Make port 8080 available to the world outside this container
EXPOSE 8080

# Run the JAR file
CMD ["java", "-jar", "app.jar"]