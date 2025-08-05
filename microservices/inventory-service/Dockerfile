# Stage 1: Build the app from full monorepo
FROM maven:3.9.3-eclipse-temurin-17 AS build
WORKDIR /build

# Copy the full monorepo so parent pom is available
COPY . .

# Build only the inventory-service module
WORKDIR /build/inventory-service
RUN mvn clean package -DskipTests

# Stage 2: Minimal runtime image
FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app
COPY --from=build /build/inventory-service/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
