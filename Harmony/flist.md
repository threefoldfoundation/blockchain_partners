## Harmony flists

Link to flist is herein

[https://hub.grid.tf/arehman/v2-harmony-0-5.flist](https://hub.grid.tf/arehman/v2-harmony-0-5.flist)

### Configuration 

#### Environment Variables

```
* pub_key - This is your SSH public key (ed25519)
* network - default (testnet) , else you can specify (mainnet, testnet, staking, partner, stress, devnet, tnet)
* keypass - The bls key password to encrypt your BLS key (default : keypass = tfhmy2020)
```
Every instance starts with a newly generated BLS key with the password provided by you as an environment variable. Alternately, to use your old keys you can copy the keys into the config directory and edit the [Dockerfile](Dockerfile) and modify the script [start_hmy.sh](scripts/start_hmy.sh) to use that key and start your harmony node.

### Where are my BLS keys stored ?

The BLS key and the password file could be found here,

``` ~/.hmy/blskeys/ or here /root/.hmy/blskeys/```

### Data Persistence - Where to mount host volume ?

By default, this flist uses the ```/opt``` directory and all data for harmony is within it. 





