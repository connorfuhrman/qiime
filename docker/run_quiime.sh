#!/bin/bash

xhost + 127.0.0.1

docker run --rm -it \
       -e DISPLAY=host.docker.internal:0 \
       connorfuhrman/qiime2-gui
