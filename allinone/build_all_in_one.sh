#!/bin/bash -e

# source "$(dirname "${BASH_SOURCE[0]}")"/../../scripts/config

export http_proxy=http://child-prc.intel.com:913
export https_proxy=http://child-prc.intel.com:913
export no_proxy=localhost,127.0.0.0/8,::1,.intel.com

docker build --build-arg SLURM_TAG="slurm-21-08-8-1" --progress=plain -t llm_slurm_all_in_one:1.0 \
    --build-arg http_proxy --build-arg https_proxy --build-arg no_proxy \
    .