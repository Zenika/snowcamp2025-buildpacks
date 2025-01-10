# Buildpack demo

## Choose builder

```bash
pack builder suggest
```

## Build images

### Node backend

```bash
pack build snowcamp-node-backend --builder=paketobuildpacks/builder-jammy-base --path ./node-backend/
```

### Node frontend with NGINX

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

### Springboot application

Build it with

```bash
pack build snowcamp-springboot-backend --builder paketobuildpacks/builder-jammy-base --path springboot-backend/
```


## Inspect images

```bash
pack inspect snowcamp-node-frontend
``` 
