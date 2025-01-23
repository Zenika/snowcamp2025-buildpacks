#!/bin/bash

########################
# include the magic
########################
. $HOME/bin/demo-magic.sh

clear

p "Démarrage de l'application springboot..."
pei "docker container run -p 8080:8080 -e JAVA_TOOL_OPTIONS=-Xmx1G --name snowcamp-springboot-backend -d snowcamp-springboot-backend"

p "Vérification de la variable d'environnement vue par le process java"

pei "curl http://localhost:8080/actuator/env | jq '.propertySources[] | select(.name == \"systemEnvironment\")| .properties.JAVA_TOOL_OPTIONS.value'"

pei "docker container stop snowcamp-springboot-backend"
pei "docker container rm snowcamp-springboot-backend"

p "Tentative d'ajout de opentelemetry..."
pei "pack build snowcamp-springboot-backend --builder paketobuildpacks/builder-jammy-base --path springboot-backend  --buildpack paketo-buildpacks/opentelemetry@2.7.0"

p "Que faire?... Builder inspect!"
pei "pack builder inspect paketobuildpacks/builder-jammy-base"

p "Ce coup ci c'est la bonne..."
pei "pack build snowcamp-springboot-backend --builder paketobuildpacks/builder-jammy-base --path springboot-backend -e BP_OPENTELEMETRY_ENABLED=true --buildpack paketo-buildpacks/java@17.4.0  --buildpack paketo-buildpacks/opentelemetry@2.7.0"

p "Démarrage de l'application springboot..."
pei "docker container run -p 8080:8080 -e JAVA_TOOL_OPTIONS=-Xmx1G --name snowcamp-springboot-backend -d snowcamp-springboot-backend"

p "Vérification de la variable d'environnement vue par le process java"

pei "curl http://localhost:8080/actuator/env | jq '.propertySources[] | select(.name == \"systemEnvironment\")| .properties.JAVA_TOOL_OPTIONS.value'"

pei "docker container stop snowcamp-springboot-backend"
pei "docker container rm snowcamp-springboot-backend"

