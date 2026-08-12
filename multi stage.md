why multi stage

Builder Stage
-------------
Maven
Source Code
Dependencies
Compilation

       │
       ▼

Runtime Stage
-------------
Only app.jar
JRE



FROM maven:3.9-openjdk-17

WORKDIR /app
COPY . .
RUN mvn package

CMD ["java", "-jar", "target/app.jar"]

with multistage
---------------------
# Stage 1 - Build
FROM maven:3.9-openjdk-17 AS builder

WORKDIR /app
COPY . .
RUN mvn clean package

# Stage 2 - Runtime
FROM eclipse-temurin:17-jre

WORKDIR /app
COPY --from=builder /app/target/app.jar app.jar

CMD ["java", "-jar", "app.jar"]

Why remove source code?
Smaller image

Without multi-stage:

Source code 100 MB
Maven cache 500 MB

JDK 300 MB

App JAR 50 MB

-----------------------
Total 950 MB

With multi-stage:


JRE 150 MB
App JAR 50 MB
-----------------------
Total 200 MB
