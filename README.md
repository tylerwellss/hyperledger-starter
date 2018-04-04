# A starter project to run Hyperledger Fabric 1.1, Hyperledger Composer, and Hyperledger Explorer together

This README will assume we are running things locally on macOS. For Windows and Ubuntu setups, be sure to check the official documentation, as those include extra or different steps.

## Fabric Prerequisites

[Official Hyperledger Fabric prerequisites (includes extra steps for Windows users not listed here)](http://hyperledger-fabric.readthedocs.io/en/release-1.1/prereqs.html)

* Docker
* Node (tested on 8.9.0)
  * You may encounter some permission problems when running scripts, especially in production. To avoid this, be sure to install node as a non-root user using [nvm](https://github.com/creationix/nvm).
* Go
* Python

Fabric binaries are located in the bin directory. To use fabric binaries, set your path after cloning the repo.
```
export PATH=<path-to>/bin:$PATH
```
You may also need to set your Go path.
```
export PATH=$PATH:$GOPATH/bin
```

## Composer Prerequisites

[Official Hyperledger Composer prerequisites)](http://hyperledger-fabric.readthedocs.io/en/release-1.1/prereqs.html)

This assumes you've installed the Fabric prerequisites.

* Install Essential CLI Tools
    * npm install -g composer-cli
* Install utility to generate Composer's REST server
    * npm install -g composer-rest-server

## Explorer Prerequisites

This assumes you've installed prerequisites for both Fabric and Composer.

* Install PostgresQL 9.5 or greater
    * [Click here to download](https://www.postgresql.org/download/)