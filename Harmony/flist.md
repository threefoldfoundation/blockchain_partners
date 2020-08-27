## Harmony flists

Link to flist is herein

[https://hub.grid.tf/arehman/v2-harmony-0-8.flist](https://hub.grid.tf/arehman/v2-harmony-0-8.flist)

This flist uses the following version of harmony's binary,
#### Harmony (C) 2020. harmony, version v6268-v2.3.4-0-g7a6fd23f (jenkins@ 2020-08-17T19:56:10+0000)

In case there is a new version, you can always update the URL in the Dockerfile, build a new image and create an flist. To know more about Harmony's binary and its usage, [See this link](https://docs.harmony.one/home/validators/node-setup/installing-updating/installing-node/using-binary-cli)

### Configuration 

#### Environment Variables

```
* pub_key - This is your SSH public key (ed25519)
* network - default (mainnet) , else you can specify (mainnet, testnet, staking, partner, stress, devnet, tnet)
* keypass - The bls key password to encrypt your BLS key (default : keypass = tfhmy2020)
* shard - Possible values (0,1,2,3), Default value is 0
```
Every instance starts with a newly generated BLS key with the password provided by you as an environment variable. Alternately, to use your old keys you can copy the keys into the config directory and edit the [Dockerfile](Dockerfile) and modify the script [start_hmy.sh](scripts/start_hmy.sh) to use that key and start your harmony node.

### Where are my BLS keys stored ?

The BLS key and the password file could be found here,

``` ~/.hmy/blskeys/ or here /root/.hmy/blskeys/```

### Data Persistence - Where to mount host volume ?

By default, this flist uses the ```/opt``` directory and all data for harmony is within it. 

### Harmony Logs

The logs could be viewed under the directory ```cd /opt/latest```

