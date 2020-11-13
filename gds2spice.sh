#!/bin/bash
export MAGIC=/ef/apps/ocd/magic/8.3.67-202010151618/bin/magic
export MAGTYPE=mag; export PDKPATH=/ef/tech/SW/EFS8A ; $MAGIC -dnull -noconsole -rcfile $PDKPATH/libs.tech/magic/20200408/EFS8A.magicrc  <<EOF

gds polygon subcell true
gds warning default
gds read $1.gds
load $1.mag
save $1.mag
writeall force 1.mag
select top cell
#
extract
extract style ngspice(si)
ext2spice hierarchy on
ext2spice format ngspice
ext2spice cthresh infinite
ext2spice rthresh infinite
ext2spice renumber offS
ext2spice scale off
ext2spice blackbox on
ext2spice subcircuit top auto
ext2spice global off
ext2spice $1.ext
quit -noprompt
EOF
