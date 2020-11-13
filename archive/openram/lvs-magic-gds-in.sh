#!/bin/sh
export MAGTYPE=maglef ; export PDKPATH=/ef/tech/SW.2/sky130A ; magic -rcfile $PDKPATH/libs.tech/magic/20200508/sky130A.magicrc -dnull -noconsole << EOX
gds polygon subcell true
gds warning default
gds readonly true
##########gds readonly true
gds read $1.gds
drc off
load $1
select top cell
port makeall
extract style ngspice(si)
extract
ext2spice hierarchy on
ext2spice format ngspice
ext2spice cthresh infinite
ext2spice rthresh infinite
ext2spice renumber off
ext2spice scale off
ext2spice blackbox on
ext2spice subcircuit top auto
ext2spice global off
ext2spice $1
feedback save $1.ext.log
quit -noprompt
EOX

/ef/apps/bin/netgen -noconsole << EOF
readnet $1.spice
readnet $1.sp
lvs {$1.sp $1} {$1.spice $1}  $PDKPATH/libs.tech/netgen/sky130A_setup.tcl $1.lvs.report
quit
EOF
