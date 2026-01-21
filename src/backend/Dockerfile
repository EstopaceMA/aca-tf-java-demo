# Runtime-only image (requires local build first)
FROM mcr.microsoft.com/openjdk/jdk:21-ubuntu

WORKDIR /app

COPY target/quarkus-app/lib/ /app/lib/
COPY target/quarkus-app/*.jar /app/
COPY target/quarkus-app/app/ /app/app/
COPY target/quarkus-app/quarkus/ /app/quarkus/

EXPOSE 8080

ENTRYPOINT ["java", "-Dquarkus.http.host=0.0.0.0", "-jar", "/app/quarkus-run.jar"]
