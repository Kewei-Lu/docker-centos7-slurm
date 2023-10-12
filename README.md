# Slurm on CentOS 7 Docker Image with Confless and Dynamic Nodes

An extended slurm all-in-one docker images based on [docker-centos7-slurm](https://github.com/giovtorres/docker-centos7-slurm).

It enables [Configless](https://slurm.schedmd.com/configless_slurm.html) and [Dynamic Nodes](https://slurm.schedmd.com/dynamic_nodes.html) to get rid of config files in compute nodes and pre-allocation of compute nodes.

It works fine with `slurm 23.02.5`, for other version of `slurm`, the feasibility is not guaranteed. 
## Requirement

* `Slurm` requires `22.05` or later, we use `23.02` in quickstart
* `Openssl` with `1.1.1s` (original `1.1.1l` not works, no other versions are tested yet)

## QuickStart


Pull the codes, build the image.

```shell
docker docker build --build-arg SLURM_TAG="slurm-23-02-5-1" -t  docker-slurm:dynamic
```

Run the image, map the port for `slurmctld` inside container to host to test the nodes' dynamic join the cluster.

```bash
docker run -it -h slurmctl -p 38125:6817 --cap-add sys_admin docker-slurm:dynamic
```

After everything is up, you can see the slurm cluster status:

```shell
[root@slurmctl /]# sinfo
PARTITION AVAIL  TIMELIMIT  NODES  STATE NODELIST
debug        up 5-00:00:00      2   idle c[3-4]
normal*      up 5-00:00:00      2   idle c[1-2]
f1Feature    up   infinite      0    n/a
```

### Join a node within the container
open another terminal inside the container, join a new node to partition `f1Feature`

```bash
slurmd -Z --conf "Feature=f1" --conf-server localhost:6817 -N dynamic_1
```

After that, you should see the node using `sinfo`

```bash
PARTITION  AVAIL  TIMELIMIT  NODES  STATE NODELIST
debug         up 5-00:00:00      2   idle c[3-4]
normal        up 5-00:00:00      2   idle c[1-2]
f1Feature*    up   infinite      1   idle dynamic_1
```

### Join a node from host

Be sure that `slurmd` is installed in host env and the version is `22.05` or later

Run commands below in host environment

```bash
slurmd -Z --conf "Feature=f1" --conf-server localhost:38125 -N dynamic_1 -Dvvvv
```