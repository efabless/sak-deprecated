#!/bin/sh

export PROJECT=$1;
export CELL_NAME=$2;
export LIBRARY_NAME=$3;

#export PROJECT=lmi814l;
#export CELL_NAME=lmi814B_22oct2020;
#export LIBRARY_NAME=lmi814l.delib;

cd ~/design/$PROJECT/elec
elec2spi -o $CELL_NAME.elec.spi -LP -TS -NTI $LIBRARY_NAME $CELL_NAME.sch >& elec2spi.$CELL_NAME.log


