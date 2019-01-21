#!/bin/bash
docker run -it -v ${PWD}/example:/example -v ${PWD}/work:/work --rm philippgadow/checkmate /bin/bash
