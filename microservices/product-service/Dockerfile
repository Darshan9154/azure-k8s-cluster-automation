# Stage 1: Build from full monorepo
FROM maven:3.9.3-eclipse-temurin-17 AS build
WORKDIR /build
COPY . .
WORKDIR /build/product-service
RUN mvn clean package -DskipTests

# Stage 2: Runtime
FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app
COPY --from=build /build/product-service/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
