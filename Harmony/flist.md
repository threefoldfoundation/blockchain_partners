## Harmony flists

Link to flist is herein

[https://hub.grid.tf/arehman/v2-harmony-0-6.flist](https://hub.grid.tf/arehman/v2-harmony-0-6.flist)

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

### Harmony Logs

The logs could be viewed under the directory ```cd /opt/latest```

### Sync status

Here is how you can do it and you can see the output below,

##### /opt/latest#  curl https://monitor.hmny.io/status?network=mainnet | json_pp

```
root@cluster01:/opt/latest#  curl https://monitor.hmny.io/status?network=mainnet | json_pp
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   932  100   932    0     0   1331      0 --:--:-- --:--:-- --:--:--  1331
{
   "shard-status" : [
      {
         "current-epoch" : 250,
         "shard-id" : "3",
         "current-block-number" : 4444455,
         "block-timestamp" : "2020-08-18 19:35:06 +0000 UTC",
         "leader-address" : "one1aywupeg53g38z2y009mzuwdw5u9lwsy2e5yetw",
         "consensus-status" : true
      },
      {
         "consensus-status" : true,
         "leader-address" : "one1u0kt4ng2x9c0zl0jv57rwj4rvw8fhem2vqksdv",
         "block-timestamp" : "2020-08-18 19:35:08 +0000 UTC",
         "shard-id" : "1",
         "current-block-number" : 4419388,
         "current-epoch" : 250
      },
      {
         "shard-id" : "0",
         "current-block-number" : 4426217,
         "block-timestamp" : "2020-08-18 19:35:07 +0000 UTC",
         "current-epoch" : 250,
         "consensus-status" : true,
         "leader-address" : "one1gh043zc95e6mtutwy5a2zhvsxv7lnlklkj42ux"
      },
      {
         "consensus-status" : true,
         "leader-address" : "one1xdnm2fj6hyk7e49af2h9dmudkdlta9q354094e",
         "shard-id" : "2",
         "current-block-number" : 4457412,
         "block-timestamp" : "2020-08-18 19:35:11 +0000 UTC",
         "current-epoch" : 250
      }
   ],
   "avail-seats" : 640,
   "commit-version" : [
      "v6268-v2.3.4-0-g7a6fd23f"
   ],
   "used-seats" : 640,
   "validators" : 75```






