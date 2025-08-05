# Stage 1: Build the app
FROM maven:3.9.3-eclipse-temurin-17 AS build
WORKDIR /build

# ⛳️ Copy the entire monorepo (from root context) into /build
COPY . .

# 📍 Move into the notification-service folder and build only that module
WORKDIR /build/notification-service
RUN mvn clean package -DskipTests

# Stage 2: Create a slim runtime image
FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app
COPY --from=build /build/notification-service/target/notification-service-*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
