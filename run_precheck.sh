#!/bin/bash

source /mnt/share/open_mpw/sak/set_open_mpw.sh

CWD=`pwd`
cd /mnt/share/open_mpw/precheck

docker run -it -e TARGET_PATH=$TARGET_PATH -e PDK_ROOT=$PDK_ROOT -v $(pwd):/usr/local/bin -v $TARGET_PATH:$TARGET_PATH -v $PDK_ROOT:$PDK_ROOT -u $(id -u $USER):$(id -g $USER) efabless/open_mpw_precheck:latest ./run_precheck

cd $CWD
