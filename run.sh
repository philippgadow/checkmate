#!/bin/bash
docker run -it -v ${PWD}/example:/example -v ${PWD}/work:/work -e MASS_MZp=${1} -e MASS_MDM=${2} -e MASS_MHs=${3} --rm philippgadow/checkmate /work/run_in_docker.sh
