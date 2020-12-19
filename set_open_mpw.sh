#!/bin/bash

export PDK_ROOT=~/open_mpw/pdk
export TARGET_PATH=$(pwd)

export CDRCREPO=~/open_mpw/openflow-drc-tests
export CDRCWAIVE=~/open_mpw/caravel/doc/signoff/waivers
export CDRCSUMMARY=~/open_mpw/caravel/doc/signoff/calibreSummary.py

mkdir -p doc/signoff/cdrcpost
export CDRCLOG=$(pwd)/doc/signoff/cdrc.log
export CDRCPOST=$(pwd)/doc/signoff/cdrcpost

echo "PDK_ROOT = $PDK_ROOT"
echo "TARGET_PATH = $TARGET_PATH"
echo
echo "CDRCREPO = $CDRCREPO"
echo "CDRCWAIVE = $CDRCWAIVE"
echo "CDRCSUMMARY = $CDRCSUMMARY"
echo
echo "CDRCLOG = $CDRCLOG"
echo "CDRCPOST = $CDRCPOST"


