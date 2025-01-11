# Buildpack demo

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

## Cache

### Local cache

```bash
docker volume ls
# create container with volume and look inside
cat "sha256:....tar" | tar tvf -
```

## Inspect images

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

