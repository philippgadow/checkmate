#!/bin/bash

docker run -it -v ${PWD}/example:/example -v ${PWD}/work:/work --rm philippgadow/checkmate /work/run_example_in_docker.sh
