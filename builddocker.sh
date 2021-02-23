#!/bin/bash

rm -rf core
git clone https://github.com/Netherlandschat/Core.git core

cd core
chmod +x gradlew
./gradlew shadowjar

cp build/libs/*.jar ../Core-Docker.jar

cd ..
docker build -t netherlandsbot-core:latest .