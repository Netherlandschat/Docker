#!/bin/bash

echo "Running preflight checks..."

#Check if environmental variables are defined indicating that the user wants some modules
if [[ ! -z "$HOI_MODULE" && ! -f "/modules/HoiModule.jar" ]]
then
    echo "HoiModule Environmental variable set, and module is not yet present. Building..."
    cd /
    mkdir -p /tmp/modules/HoiModule/
    git clone https://github.com/Netherlandschat/HoiModule.git /tmp/modules/HoiModule/

    cd /tmp/modules/HoiModule/
    chmod +x gradlew
    ./gradlew dockerBuild

    cp /tmp/modules/HoiModule/build/libs/HoiModule.jar /modules/HoiModule.jar
    rm -rf /tmp/modules/HoiModule/
    echo "HoiModule built."
fi

if [[ ! -z "$TCP_MODULE" && ! -f "/modules/TcpModule.jar" ]]
then
    echo "TcpModule Environmental variable set, and module is not yet present. Building..."
    cd /
    mkdir -p /tmp/modules/TcpModule/
    git clone https://github.com/Netherlandschat/TCPModule.git /tmp/modules/TcpModule

    cd /tmp/modules/TcpModule
    chmod +x gradlew
    ./gradlew dockerBuild

    cp /tmp/modules/TcpModule/build/libs/TcpModule.jar /modules/TcpModule.jar
    rm -rf /tmp/modules/TcpModule
    echo "TcpModule built."
fi

if [[ ! -z "$DICK_MEASURING_CONTEST" && ! -f "/modules/DickMeasuringContest.jar" ]]
then
    echo "DickMeasuringContest module Environmental variable set, and module is not yet present. Building..."
    cd /
    mkdir -p /tmp/modules/DickMeasuringContest
    git clone https://github.com/Netherlandschat/DickMeasuringContest.git /tmp/modules/DickMeasuringContest

    cd /tmp/modules/DickMeasuringContest
    chmod +x gradlew    
    ./gradlew dockerBuild
    
    cp /tmp/modules/DickMeasuringContest/build/libs/DickMeasuringContest.jar /modules/DickMeasuringContest.jar
    rm -rf /tmp/modules/DickMeasuringContest
    echo "DickMeasuringContest built."
fi

echo "Preflight checks complete. Starting Core."

cd /app
/usr/bin/java -jar /app/Core-Docker.jar