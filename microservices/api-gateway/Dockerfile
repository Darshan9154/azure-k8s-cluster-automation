# Stage 1: Build the application from the monorepo root
FROM maven:3.9.3-eclipse-temurin-17 AS build
WORKDIR /build
COPY . .
WORKDIR /build/api-gateway
RUN mvn clean package -DskipTests

# Stage 2: Create minimal runtime image
FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app
COPY --from=build /build/api-gateway/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
