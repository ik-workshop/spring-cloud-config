#!/bin/sh

java -jar  ./app.jar ${JAVA_OPTS} ${BOOT_LAUNCHER} \
--server.port=8080 \
--spring.config.name=application "$@"
