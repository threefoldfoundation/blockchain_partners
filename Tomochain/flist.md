# Tomo flists

This flist will start a TomoChain Full Node. To create a TomoChain Master node, [See here](https://docs.tomochain.com/masternode-and-dex/masternode/run-a-full-node/create-a-tomochain-masternode)

Link to flist is herein

[https://hub.grid.tf/arehman/v2-tomo-0-7.flist](https://hub.grid.tf/arehman/v2-tomo-0-7.flist)

### Configuration 

#### Environment Variables

```
* pub_key - This is your SSH public key (ed25519)
* NETWORK_ID - default (Mainnet [88]) , else you can specify (Testnet [89])
* KEYPASS - The key password to encrypt / generate your new Tomo account (default : keypass = tf2020)
* BOOTNODES - Specify a BOOTNODE, else default (enode://97f0ca95a653e3c44d5df2674e19e9324ea4bf4d47a46b1d8560f3ed4ea328f725acec3fcfcb37eb11706cf07da669e9688b091f1543f89b2425700a68bc8876@3.212.20.0:30301)

```
Every instance starts with a newly generated Tomo account with the key/password provided by you as an environment variable. Alternately, to use your old keys you can copy the keys into the config directory and edit the [Dockerfile](Dockerfile) and modify the script [start_tomo.sh](scripts/start_tomo.sh) to use that key and start your TomoChain node.

### Where is TomoChain  ?

The TomoChain account and keys could be found here, layout is below which you can see with tree -dh

```/opt/keys

|-- [4.0K]  data
|   |-- [4.0K]  tomo
|   |   |-- [4.0K]  chaindata
|   |   `-- [4.0K]  nodes
|   `-- [4.0K]  tomox
`-- [4.0K]  keys
```



### Data Persistence - Where to mount host volume ?

By default, this flist uses the ```/opt``` directory and all data for harmony is within it. 
