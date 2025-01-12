# Buildpack demo

## Tools needed

* [docker](https://docs.docker.com/engine/install/)
* [pack cli](https://buildpacks.io/docs/for-platform-operators/how-to/integrate-ci/pack/#pack-cli)
* [trivy](https://trivy.dev/v0.18.3/installation/)
* curl and jq

For ubuntu, a [script](./init-vm.sh) is provided.

## Build images

### Choose a builder

```bash
pack builder suggest
```

### Build node backend

```bash
pack build snowcamp-node-backend --builder=paketobuildpacks/builder-jammy-base --path ./node-backend/
```

### Build node frontend with NGINX

Build it with

```bash
pack build snowcamp-node-frontend --builder=paketobuildpacks/builder-jammy-base --path ./node-frontend/
```

and run it with

```bash
docker run --rm   --env PORT=8080 -p 8080:8080 snowcamp-node-frontend
```

Also, clean sources

```bash
pack build snowcamp-node-frontend --builder=paketobuildpacks/builder-jammy-base --path ./node-frontend/ --env BP_INCLUDE_FILES='dist/node-frontend/browser/*'
```

### Build springboot application

Build it with

```bash
pack build snowcamp-springboot-backend --builder paketobuildpacks/builder-jammy-base --path springboot-backend/
```

### Local cache

```bash
docker volume ls
# create container with volume and look inside
cat "sha256:....tar" | tar tvf -
```

### Inspect images

```bash
pack inspect snowcamp-node-frontend
```

## Rebase image 

Build with old run image 

```
pack build snowcamp-springboot-backend --builder paketobuildpacks/builder-jammy-base --path springboot-backend --run-image paketobuildpacks/run-jammy-base:0.0.1
```

Scan vulnerabilities

```bash
trivy image snowcamp-springboot-backend --severity HIGH,CRITICAL
```


Do rebase

```bash
pack rebase snowcamp-springboot-backend --run-image paketobuildpacks/run-jammy-base:latest --force
```

Scan it now

## Collaboration en environment variables


```bash
docker run --rm -p 8080:8080 snowcamp-springboot-backend:latest 
```

Run 

```bash
curl http://localhost:8080/actuator/env | jq '.propertySources[] | select(.name == "systemEnvironment")| .properties.JAVA_TOOL_OPTIONS.value'
```

Add builder opentelemetry

```
pack build snowcamp-springboot-backend --builder paketobuildpacks/builder-jammy-base --path springboot-backend -e BP_OPENTELEMETRY_ENABLED=true --buildpack paketo-buildpacks/java@17.4.0  --buildpack paketo-buildpacks/opentelemetry@2.7.0
```

Look at runtime `JAVA_TOOL_OPTIONS` environment again. Run container providing a `JAVA_TOOL_OPTIONS`.

```bash
docker run --rm -p 8080:8080 -e JAVA_TOOL_OPTIONS="-Xms256m -Xmx512m" snowcamp-springboot-backend:latest
```

See append files

```bash
docker container run --rm --entrypoint bash -u 0   snowcamp-springboot-backend -c "find /layers/ -type f -name JAVA_TOOL_OPTIONS.append -exec cat {} \; -exec echo '' \; -print"
```

You may also init a new buildpack with `pack buildpack new` and put `sleep` command in both `detect` and `build` scripts and connect to running containers to look into produced layers.
