# DPDK pcap replayer 

## Dependencies

| Application | Version |
| ----------- | ------- |
| cmake       | >=3.16  |
| meson       | 1.3.1   |
| DPDK        | 22.11   |

## Installation instructions

1. Run `setup.sh` to install dependencies locally.
   - **Note:** you only need to run this once to install the dependencies.
2. Build with meson by running `build.sh`.
3. Source the paths file: `source paths.sh`.
4. Run `Debug/bin/pcap-replay` or `Release/bin/pcap-replay`.

## Running

Like every DPDK application, one must go through the EAL arguments first, and only then consider the application specific arguments, like such:

```
$ sudo ./Debug/bin/pcap-replay $EAL_ARGS -- $PKTGEN_ARGS
```

To bring up the help menu from pcap-replay specifically, one can use a testing EAL configuration:

```
$ sudo ./Debug/bin/pcap-replay --no-huge --no-shconf --vdev "net_tap0,iface=test_rx" --vdev "net_tap1,iface=test_tx" -- --help
```

## Testing

Example pcap-replay configuration (for testing purposes):

```
$ sudo ./Debug/bin/pcap-replay -m 8192 --no-huge --no-shconf --vdev "net_tap0,iface=test_rx" --vdev "net_tap1,iface=test_tx" -- --tx 1 --rx 0 --tx-cores 4 
```
