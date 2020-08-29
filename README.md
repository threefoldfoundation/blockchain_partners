# ThreeFold Blockchain Partners

## What is Here ?

This is a public repository where we maintain flists and docker images for our blockchain partners to enable their users to seamlessly deploy on the ThreeFold grid. We invite developers, engineers, end users and other members from their respective communities to contribute and update flists, docker images and other technical information in this respository.

## What do we expect and why do we encourage to contribute ?

* To ensure that we have the latest and updated information from each of our blockchian partner
* To ensure that our partners and their communities have a seamless deployment experience on the ThreeFold Grid
* To innovate and float ideas that can enhance the user experience and overall benefit everybody
* To highlight issues and problems and collaborate together to provide solutions

## How this repository is structured ?

Every blockchain partner has a folder in this repository and all information with respect to that partner is only and only in that folder. The folder structure for the partner is herein,

```
├── partners
│   ├── Dockerfile
│   ├── README.md
│   ├── config
│   ├── examples
│   ├── flist.md
│   ├── images
│   └── scripts
```

* README.md - Every partner has his own README.md that should contain all the necessary information to deploy their node
* The Dockerfile contains code on how to build the docker image
* The examples directory can contain any HowTos or any tutorials or any other helpful information for the community or end users
* The scripts directory can contain all the scripts to automate, deploy, build, monitor for the partner node
* The config directory may contain user specific configuration / settings / files / keys required to build into the image
* flist.md will contain link to partner's flist and any information related to it
* images directory to contain all images / screenshots used in Readme's / HowTo's

### Current Status of Partner Images / Flists

| Partner   | flist                                            | Node Type | Status   | Last Updated |
|-----------|--------------------------------------------------|-----------|----------|--------------|
| Harmony   | https://hub.grid.tf/arehman/v2-harmony-1-3.flist | Full Node | Verified | 27 Aug 2020  |
| TomoChain | https://hub.grid.tf/arehman/v2-tomo-1-1.flist    | Full Node | Verified | 29 Aug 2020  |
| Digibyte  | Work in Progress                                 | Full Node | Pending  |   Pending    |

### Maintainers of this repository

- [Abdul Rehman](https://github.com/abdulgig) 
- [Benjelloun Oussama](https://github.com/BenjellounO)
