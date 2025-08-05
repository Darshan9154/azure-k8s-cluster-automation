# Stage 1: Build the application from full monorepo
FROM maven:3.9.3-eclipse-temurin-17 AS build
WORKDIR /build
COPY . .
WORKDIR /build/discovery-server
RUN mvn clean package -DskipTests

# Stage 2: Run the application
FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app
COPY --from=build /build/discovery-server/target/*.jar app.jar
EXPOSE 8761
ENTRYPOINT ["java", "-jar", "app.jar"]
