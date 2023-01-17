FROM docker.io/library/gradle:7.5.1-jdk17 AS build

WORKDIR /app

# add project
ADD . /app/

RUN gradle clean bootJar

FROM docker.io/library/eclipse-temurin:17-jre-focal AS app

WORKDIR /app
COPY --from=build /app/build/libs/spring-petclinic-3.0.0.jar .

EXPOSE 8080

# server run
ENTRYPOINT ["java"]
CMD ["-jar", "/app/spring-petclinic-3.0.0.jar"]
