# Workshop Blueprint

Spring Cloud Config is Spring's client/server approach for storing and serving distributed configurations across multiple applications and environments.

This configuration store is ideally versioned under Git version control and can be modified at application runtime. While it fits very well in Spring applications using all the supported configuration file formats together with constructs like Environment, PropertySource or @Value, it can be used in any environment running any programming language.

A workshop uses [Spring Cloud Config Server](https://docs.spring.io/spring-cloud-config/docs/3.1.0/reference/html/).

---

![](https://img.shields.io/github/commit-activity/m/ik-workshop/spring-cloud-config)
![](https://img.shields.io/github/last-commit/ik-workshop/spring-cloud-config)
[![](https://img.shields.io/github/license/ivankatliarchuk/.github)](https://github.com/ivankatliarchuk/.github/LICENCE)
[![](https://img.shields.io/github/languages/code-size/ik-workshop/spring-cloud-config)](https://github.com/ik-workshop/spring-cloud-config)
[![](https://img.shields.io/github/repo-size/ik-workshop/spring-cloud-config)](https://github.com/ik-workshop/spring-cloud-config)
![](https://img.shields.io/github/languages/top/ik-workshop/spring-cloud-config?color=green&logo=markdown&logoColor=blue)

---

- [Spring Cloud Initializer](https://start.spring.io)

---

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
## Contents

- [Strategies for storing configuration properties](#strategies-for-storing-configuration-properties)
  - [A Git Repository as Configuration Storage](#a-git-repository-as-configuration-storage)
- [Run Service](#run-service)
    - [Parameters](#parameters)
    - [Environment Variables](#environment-variables)
  - [Configuring Spring Cloud Config Server](#configuring-spring-cloud-config-server)
- [Required Backend Configuration](#required-backend-configuration)
  - [Actuator](#actuator)
  - [Additional Features](#additional-features)
    - [Push notifications with Spring Cloud Bus](#push-notifications-with-spring-cloud-bus)
- [Create](#create)
- [Resources](#resources)
- [TODO](#todo)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

---

## Strategies for storing configuration properties

Spring Cloud Config relies on three parameters to identify which properties should be returned to an application:

- `{application}`: the name of the application.
- `{profile}`: client's current active application profile.
- `{label}`: a discriminator defined by the specific Environment Repository back-end. In the case of Git, a label can be a commit id, a branch name, or a tag.

The Git-backed configuration API provided by our server can be queried using the following paths:

```
/{application}/{profile}[/{label}]
/{application}-{profile}.yml
/{label}/{application}-{profile}.yml
/{label}/{application}-{profile}.json
/{application}-{profile}.properties
/{label}/{application}-{profile}.properties
```

| Path             | Description  |
|------------------|--------------|
| /{app}/{profile} | Configuration data for app in Spring profile (comma-separated).|
| /{app}/{profile}/{label} | Add a git label |
| /{app}/{profile}{label}/{path} | An environment-specific plain text config file (at "path") |

### A Git Repository as Configuration Storage

To complete our server, we have to initialize a _Git_ repository under the configured url, create some new properties files and popularize them with some values.

The name of the configuration file is composed like a normal Spring _application.properties_, but instead of the word ‘application' a configured name, e.g. the value of the property _‘spring.application.name'_ of the client is used, followed by a dash and the active profile. For example:

```bash
$> git init
$> echo 'user.role=Developer' > config-client-development.properties
$> echo 'user.role=User'      > config-client-production.properties
$> git add .
$> git commit -m 'Initial config-client properties'
```

### Example Requests

Assume the [GIT REPO](https://github.com/ik-workshop/config-samples) is used

```
curl --location --request GET 'http://localhost:8882/team-a-dev.json'
curl --location --request GET 'http://localhost:8882/team-a-dev.yml'
curl --location --request GET 'http://localhost:8882/team-a-dev.properties'

curl --location --request GET 'http://localhost:8882/team-a/mem-service'
curl --location --request GET 'http://localhost:8882/greeting-service-staging.json'
curl --location --request GET 'http://localhost:8882/team-a-userservice.json'
```

## Run Service

#### Parameters
* `-p 8888` Server port
* `-v /config` Mounted configuration

#### Environment Variables

* `JAVA_OPTS` Specify VM Options or System Properties

###  Configuring Spring Cloud Config Server

Spring Cloud Config Server is a normal Spring Boot application, it can be configured through all the ways a
Spring Boot application can be configured.  You may use environment variables or you can mount configuration in
the provided volume.  The configuration file must be named **application** and may be a properties or yaml file.
See the [Spring Boot documentation](http://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/#boot-features-external-config)
for further information on how to use and configure Spring Boot.

## Required Backend Configuration

Spring Cloud Config Server **requires** that you configure a backend to serve your configuration files.  There are currently 6 backends to choose from...

### Actuator

The [Spring Boot actuator](https://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/#production-ready) is
enabled by default.  [See the Spring Boot documentation](https://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/#actuator-properties)
for configuration options.  The actuator can be disabled entirely by including the `no-actuator` profile

### Additional Features

#### Push notifications with Spring Cloud Bus

Spring Cloud Bus links the nodes of a distributed system with a lightweight message broker.  It allows clusters of
applications configured with **RefreshScope** to automatically reload configuration without restarting.

[See the Spring Cloud Conifg](https://docs.spring.io/spring-cloud-config/docs/2.2.6.RELEASE/reference/html/#_push_notifications_and_spring_cloud_bus) and
[Spring Cloud Bus](https://cloud.spring.io/spring-cloud-bus/reference/html) documentation for more details

## Create

[**Create a repository using this template →**][template.generate]

## Resources

## TODO

- [ ] Serve Private Resository
- [ ] Helm charts
- [ ] Example queries
- [ ] Tests

<!-- resources -->
[template.generate]: https://github.com/ik-workshop/spring-cloud-config/generate
[code-style.badge]: https://img.shields.io/badge/code_style-prettier-ff69b4.svg?style=flat-square

[governance-badge]: https://github.com/ik-workshop/spring-cloud-config/actions/workflows/governance.bot.yml/badge.svg
[governance-action]: https://github.com/ik-workshop/spring-cloud-config/actions/workflows/governance.bot.yml

[governance.link-checker.badge]: https://github.com/ik-workshop/spring-cloud-config/actions/workflows/governance.links-checker.yml/badge.svg
[governance.link-checker.status]: https://github.com/ik-workshop/spring-cloud-config/actions/workflows/governance.links-checker.yml
