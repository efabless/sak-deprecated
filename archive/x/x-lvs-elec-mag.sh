#!/bin/sh

export PROJECT=lmi814l;
export CELL_NAME=lmi814A_22oct2020;
export LIBRARY_NAME=lmi814l.delib;

cd ~/design/$PROJECT/elec
elec2spi -o $CELL_NAME.spie -LP -TS -NTI $LIBRARY_NAME $CELL_NAME.sch >& elec2spi.$CELL_NAME.log


/ef/apps/bin/netgen -noconsole << EOF
readnet spice $1.spice
readnet spice $1.sp
lvs {$1.spice sram_2_16_sky130} {sram_2_16_sky130.sp sram_2_16_sky130} setup.tcl sram_2_16_sky130.lvs.report
quit
EOF
