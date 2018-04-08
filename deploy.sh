#!/bin/bash

# Exit on first error
set -e

# Detect architecture
ARCH=`uname -m`

echo "$(tput setaf 4)$(tput bold)************************************************$(tput sgr0)"
echo "$(tput setaf 6)$(tput bold)Deploying Hyperledger Starter. Please wait. $(tput sgr0)"
echo "$(tput setaf 6)$(tput bold)Starting Hyperledger Fabric network ... $(tput sgr0)"
echo "$(tput setaf 6)$(tput bold)Hyperledger Fabric v1.1 $(tput sgr0)"
echo "$(tput setaf 4)$(tput bold)************************************************$(tput sgr0)"

cd ./fabric/fabric-scripts/hlfv11/composer
echo "$(tput setaf 6)$(tput bold)Stopping currently running Fabric in Docker$(tput sgr0)"
docker stop mongo && docker rm mongo
docker stop rest && docker rm rest
ARCH=$ARCH docker-compose -f docker-compose.yml down
docker kill $(docker ps -q) && docker rm $(docker ps -aq)

echo "$(tput setaf 6)$(tput bold)Starting Fabric in Docker  $(tput sgr0)"
ARCH=$ARCH docker-compose -f docker-compose.yml up -d

echo "$(tput setaf 6)$(tput bold)Sleep 5 seconds while startup completes $(tput sgr0)" && sleep 5

echo "$(tput setaf 6)$(tput bold)Create PeerAdmin card $(tput sgr0)" && sleep 2
cd ../../../..
cd ./fabric/fabric-scripts/hlfv11
./createPeerAdminCard.sh
echo "$(tput setaf 6)$(tput bold)PeerAdmin card created$(tput sgr0)" && sleep 2

echo "$(tput setaf 6)$(tput bold)Creating Channel $(tput sgr0)" && sleep 2
docker exec peer0.org1.example.com peer channel create -o orderer.example.com:7050 -c composerchannel -f /etc/hyperledger/configtx/composer-channel.tx
echo "$(tput setaf 6)$(tput bold)Channel Created $(tput sgr0)" && sleep 2



echo "$(tput setaf 6)$(tput bold)Joining Peer to Channel $(tput sgr0)" && sleep 2
docker exec -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@org1.example.com/msp" peer0.org1.example.com peer channel join -b composerchannel.block
echo "$(tput setaf 6)$(tput bold)Peer Joined Channel $(tput sgr0)" && sleep 2

echo "$(tput setaf 4)$(tput bold)************************************************$(tput sgr0)"
echo "$(tput setaf 6)$(tput bold)Fabric Started! Deploying Composer network ... $(tput sgr0)"
echo "$(tput setaf 6)$(tput bold)Creating business network archive file $(tput sgr0)"
echo "$(tput setaf 4)$(tput bold)************************************************$(tput sgr0)" && sleep 2

cd ../../../composer && composer archive create -t dir -n .
echo "$(tput setaf 6)$(tput bold)Business network archive file created $(tput sgr0)" && sleep 2

echo "$(tput setaf 6)$(tput bold)Install Composer network to Fabric $(tput sgr0)" && sleep 2
composer network install --card PeerAdmin@hlfv1 --archiveFile sample-network@0.0.1.bna
echo "$(tput setaf 6)$(tput bold)Composer business network installed $(tput sgr0)" && sleep 2

echo "$(tput setaf 6)$(tput bold)Start business network $(tput sgr0)" && sleep 2
composer network start --networkName sample-network --networkVersion 0.0.1 --networkAdmin admin --networkAdminEnrollSecret adminpw --card PeerAdmin@hlfv1 --file networkadmin.card
echo "$(tput setaf 6)$(tput bold)Business network started $(tput sgr0)" && sleep 2

echo "$(tput setaf 6)$(tput bold)Remove existing network admin card $(tput sgr0)" && sleep 2
composer card delete -c admin@sample-network
echo "$(tput setaf 6)$(tput bold)Existing network admin card removed $(tput sgr0)" && sleep 2


echo "$(tput setaf 6)$(tput bold)Import network admin identity $(tput sgr0)" && sleep 2
composer card import --file networkadmin.card
echo "$(tput setaf 6)$(tput bold)Network admin identity imported $(tput sgr0)" && sleep 2

# echo "$(tput setaf 6)$(tput bold)Start Composer REST Server $(tput sgr0)"
# composer-rest-server -c admin@sample-network -n never
# echo "$(tput setaf 6)$(tput bold)Composer REST Server Started $(tput sgr0)" && sleep 2

echo "$(tput setaf 6)$(tput bold)Starting MongoDB for Rest Server $(tput sgr0)" && sleep 2
docker run -d --name mongo --network composer_default -p 27017:27017 mongo
echo "$(tput setaf 6)$(tput bold)MongoDB Started in Docker $(tput sgr0)" && sleep 2

echo "$(tput setaf 6)$(tput bold)Start Composer Rest Server $(tput sgr0)" && sleep 2
source envvars.txt
docker build -t rest .
docker run \
    -d \
    -e COMPOSER_CARD=${COMPOSER_CARD} \
    -e COMPOSER_NAMESPACES=${COMPOSER_NAMESPACES} \
    -e COMPOSER_AUTHENTICATION=${COMPOSER_AUTHENTICATION} \
    -e COMPOSER_MULTIUSER=${COMPOSER_MULTIUSER} \
    -e COMPOSER_PROVIDERS="${COMPOSER_PROVIDERS}" \
    -e COMPOSER_DATASOURCES="${COMPOSER_DATASOURCES}" \
    -v ~/.composer:/home/composer/.composer \
    --name rest \
    --network composer_default \
    -p 3000:3000 \
    rest
echo "$(tput setaf 6)$(tput bold)REST Server Started in Docker $(tput sgr0)" && sleep 2