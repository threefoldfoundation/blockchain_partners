# ThreeFold Blockchain Partners

## What is Here ?

This is a public repository where we maintain flists and docker images for our blockchain partners to enable their users to seamlessly deploy on the ThreeFold grid. We invite developers, engineers, end users and other members from their respective communities to contribute and update flists, docker images and other technical information in this respository.

## How it is structured ?

Every blockchain partner has a folder in this repository and all information with respect to that partner is only and only in that folder. The folder structure for the partner is herein,

```
├── partner_name
│   ├── Dockerfile
│   ├── README.md
│   ├── examples
│   └── scripts

```

* README.md - Every partner has his own README.md that should contain all the necessary information to deploy their node
* The Dockerfile contains code on how to build the docker image
* The examples directory can contain any HowTos or any tutorials or any other helpful information for the community or end users
* The scripts directory can contain all the scripts to automate, deploy, build, monitor for the partner node
