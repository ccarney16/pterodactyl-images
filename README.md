# Pterodactyl Supplemental Images

This repository builds supplemental container images for the
[Pterodactyl Panel](https://github.com/pterodactyl/).

## Available images

Images are published to
[`ccarney16/pterodactyl-images`](https://hub.docker.com/r/ccarney16/pterodactyl-images)
with the tags below.

### Java

| Image | Tags |
| --- | --- |
| Amazon Corretto | `jdk11-corretto` |
| Eclipse Temurin | `jdk17-temurin`, `jdk21-temurin`, `jdk25-temurin` |
| Deployable | `jdk11-deployable`, `jdk17-deployable`, `jdk21-deployable`, `jdk25-deployable` |

### GraalVM

| Image | Tags |
| --- | --- |
| GraalVM Community Edition | `graalvm-ce-jdk8`, `graalvm-ce-jdk11`, `graalvm-ce-jdk17`, `graalvm-ce-jdk21` |
| GraalVM | `graalvm-jdk25` |

The Java images use their upstream base images. Deployable images include
`ytt` and `vendir` for deployment workflows.
