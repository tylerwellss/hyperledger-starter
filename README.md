[![npm](https://img.shields.io/npm/v/npm.svg)](https://github.com/wellstyler/hyperledger-starter)
[![node](https://img.shields.io/node/v/passport.svg)](https://github.com/wellstyler/hyperledger-starter)

# A starter project to get started with a combination of Hyperledger Fabric 1.1, Hyperledger Composer, and Hyperledger Explorer

This README will assume we are running things locally on macOS. For Windows and Ubuntu setups, be sure to check the official documentation, as those include extra or different steps.

## Fabric Prerequisites

[Official Hyperledger Fabric setup docs (includes extra steps for Windows users not listed here)](http://hyperledger-fabric.readthedocs.io/en/release-1.1/prereqs.html)

* Docker
* Node (tested on 8.9.0)
  * You may encounter some permission problems when running scripts, especially in production. To avoid this, be sure to install node as a non-root user using [nvm](https://github.com/creationix/nvm).
* Go
* Python

Fabric binaries are located in the bin directory. To use fabric binaries, set your path after cloning the repo.

```bash
export PATH=<path-to>/bin:$PATH
```

You may also need to set your Go path.

```bash
export PATH=$PATH:$GOPATH/bin
```

## Composer Prerequisites

[Official Hyperledger Composer setup docs](http://hyperledger-fabric.readthedocs.io/en/release-1.1/prereqs.html)

This assumes you've installed the Fabric prerequisites.

* Install Essential CLI Tools
  * `npm install -g composer-cli`
* Install utility to generate Composer's REST server
  * `npm install -g composer-rest-server`

## Hyperledger Blockchain Explorer Prerequisites

[Official Blockchain Explorer setup docs](https://github.com/hyperledger/blockchain-explorer)

This assumes you've installed prerequisites for both Fabric and Composer.

* Install PostgresQL 9.5 or greater
  * [Click here to download](https://www.postgresql.org/download/)

## Deploy Fabric + Composer

Once you've allowed all of the prerequisites, you should be good to go. Run `./deploy.sh` to deploy a Fabric network and a Composer business network on top of that.

You'll be able to access Composer's REST API at `localhost:3000`.

## Deploy Exporer

To explore blocks, you need to deploy Hyperledger Explorer.

Docs coming soon ... (updated 4/19/2018)

<!-- ### Setup Postgres
 * Navigate to `exporer/app`.
 * `sudo -u postgres psql`
 * Run create database script: `\i app/db/explorerpg.sql`
 
### Build Hyperledger Explorer
* Navigate to `explorer/app/test` and `npm install` and `npm run test`
* Navigate to `explorer` and `npm install`
* Navigate to `explorer/client` and `npm install` and `npm test -- -u --coverage` and `npm run build`

### Run Hyperledger Explorer

From a new terminal
* Navigate to `explorer`
* Run `./start.sh`

Boom. Hyperledger Explorer should now be accessible at `http://localhost:8080`. -->
