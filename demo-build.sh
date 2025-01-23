#!/bin/bash

########################
# include the magic
########################
. $HOME/bin/demo-magic.sh

clear

p "Choisir son builder..."
pei "pack builder suggest"

p "Build d'un node backend.."
pei "pack build snowcamp-node-backend --builder=paketobuildpacks/builder-jammy-base --path ./node-backend/"

p "Inspection de l'image avec pack..."
pei "pack inspect snowcamp-node-backend"

p "Build d'un node frontend avec NGINX..."
pei "pack build snowcamp-node-frontend --builder=paketobuildpacks/builder-jammy-base --path ./node-frontend/"

p "Vérification du contenu du répertoire courant..."
pei "docker run --rm  --entrypoint bash snowcamp-node-frontend -c ls -a "

p "Suppression des sources..."
pei "pack build snowcamp-node-frontend --builder=paketobuildpacks/builder-jammy-base --path ./node-frontend/ --env BP_INCLUDE_FILES='dist/node-frontend/browser/*'"

p "Vérification que les sources ne sont plus présentes..."
pei "docker run --rm  --entrypoint bash snowcamp-node-frontend -c ls -a "

p "Construction d'une image springboot...."
pei "pack build snowcamp-springboot-backend --builder paketobuildpacks/builder-jammy-base --path springboot-backend/"

p "Inspection de l'image avec pack...."
pei "pack inspect snowcamp-springboot-backend"

p "Mais le cache... Où est-il?"
pei "docker volume ls"

 

