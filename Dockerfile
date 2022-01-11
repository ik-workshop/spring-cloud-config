# FROM --platform=$BUILDPLATFORM ${BUILD_FROM} as builder
ARG JVM_TARGET=jdk
ARG BUILD_FROM=eclipse-temurin:17.0.1_12-jre-focal@sha256:52fb4465aac5f24bbb08b26b45f5285d54eb1abedc2907a05c1e2d7e32e9fc84

FROM eclipse-temurin:17.0.1_12-jre-focal@sha256:52fb4465aac5f24bbb08b26b45f5285d54eb1abedc2907a05c1e2d7e32e9fc84 as builder

WORKDIR /build
COPY . ./

RUN sh gradlew -PjvmTarget=${JVM_TARGET} -console verbose --no-build-cache --no-daemon assemble && mv build/libs/* .

# FROM openjdk:17-alpine

# https://github.com/hyness/spring-cloud-config-server