FROM gradle:jdk17 as builder

WORKDIR /build
COPY . ./

RUN sh gradlew -PjvmTarget=16 -console verbose --no-build-cache --no-daemon assemble && mv build/libs/* .

FROM openjdk:17-alpine

RUN addgroup -S spring && adduser -S spring -G spring
USER spring:spring

WORKDIR /opt

COPY --from=builder /build/spring-cloud-config-server.jar /opt/app.jar

COPY entrypoint.sh ./

ENV BOOT_LAUNCHER=org.springframework.boot.loader.JarLauncher

LABEL org.opencontainers.image.authors="ik <cloudkats@gmail.com>" \
  org.opencontainers.image.vendor="https://github.com/cloudkats" \
  org.opencontainers.image.title="cloudkats/spring-cloud-config" \
  org.opencontainers.image.source="https://github.com/ik-workshop/spring-cloud-config/Dockerfile" \
  org.opencontainers.image.documentation="https://github.com/ik-workshop/spring-cloud-config/readme.md" \
  org.opencontainers.image.licenses="https://github.com/ik-workshop/spring-cloud-config/LICENCE" \
  org.opencontainers.image.os="alpine" \
  org.opencontainers.image.rutime="java17"

EXPOSE 8080

ENTRYPOINT ["sh", "entrypoint.sh"]
