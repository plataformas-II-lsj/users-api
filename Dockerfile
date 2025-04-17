FROM openjdk:8-jdk-alpine AS builder
WORKDIR /builder
COPY . .
RUN ./mvnw clean install

FROM openjdk:8-jre-alpine
WORKDIR /app
COPY --from=builder /builder/target/*.jar app.jar
EXPOSE 8083

ENV JWT_SECRET=PRFT
ENV SERVER_PORT=8083
ENV ZIPKIN_URL=http://localhost:9411/

ENTRYPOINT ["java", "-jar", "app.jar"]
