#!/bin/bash

########################
# include the magic
########################
. $HOME/bin/demo-magic.sh

clear

p "Build avec vieille base image..."
pei "pack build snowcamp-springboot-backend --builder paketobuildpacks/builder-jammy-base --path springboot-backend --run-image paketobuildpacks/run-jammy-base:0.0.1"

p "Scan des vulnerabilités..."
pei "trivy image snowcamp-springboot-backend --severity HIGH,CRITICAL --skip-db-update --skip-java-db-update"

p "Rebase de l'image..."
pei "pack rebase snowcamp-springboot-backend --run-image paketobuildpacks/run-jammy-base:latest --force"

p "Scan de la nouvelle images..."
pei "trivy image snowcamp-springboot-backend --severity HIGH,CRITICAL --skip-db-update --skip-java-db-update"

