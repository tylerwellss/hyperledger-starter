# Hyperledger Starter (Explorer/Fabric/Composer)

Welcome to a repo to get started with a combination of Hyperledger Fabric 1.1, Hyperledger Composer, and Hyperledger Explorer. This README will assume we are running things locally on macOS. For Windows and Ubuntu setups, be sure to check the official documentation, as those include extra or different steps.

## Fabric Prerequisites

[Official Hyperledger Fabric setup docs (includes extra steps for Windows users not listed here)](http://hyperledger-fabric.readthedocs.io/en/release-1.1/prereqs.html)

* Docker
* Node (tested on 8.9.0)
  * You may encounter some permission problems when running scripts, especially in production. To avoid this, be sure to install node as a non-root user using [nvm](https://github.com/creationix/nvm).
* Go
* Python

You might need to set some paths.

```bash
# Set path to Fabric binaries
export PATH=<path-to>/bin:$PATH

# Set path to Go
export PATH=$PATH:$GOPATH/bin
```

## Composer Prerequisites

[Official Hyperledger Composer setup docs](http://hyperledger-fabric.readthedocs.io/en/release-1.1/prereqs.html)

This assumes you've installed the Fabric prerequisites.

```bash
# Install Essential CLI Tools
npm install -g composer-cli

# Install utility to generate Composer's REST server
npm install -g composer-rest-server
```

## Hyperledger Blockchain Explorer Prerequisites

This assumes you've installed prerequisites for both Fabric and Composer.

* Install MySQL.
  * [Click here to download](https://www.mysql.com/)

## Deploy Fabric + Composer

Once you've allowed all of the prerequisites, you should be good to go. Run `./deploy.sh` to deploy a Fabric network and a Composer business network on top of that.

You'll be able to access Composer's REST API at `localhost:3000`.

## Deploy Exporer

To explore blocks, you need to deploy Hyperledger Explorer.

* Ensure explorer/config.json is using your MySQL password and username.
* Run the db/fabricexplorer.sql script (or copy/paste it into your MySQL shell)
* Run `./start.sh`
* To restart or clear the data, stop Explorer's Node process and repeat the above steps.

You should now be able to access Hyperledger Fabric Explorer at `localhost:8080`. Want to make sure it's working? Make a POST request to your Composer REST API and create a participant or asset. Explorer should update in real time.

Happy Hyperledgering!
