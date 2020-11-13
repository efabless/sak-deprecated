#!/bin/bash

export MAGTYPE=maglef;
export BASE=/ef/tech/SW;
export PDKPATH=$BASE/EFS8A ;

magic -dnull -noconsole -rcfile $PDKPATH/libs.tech/magic/current/EFS8A.magicrc <<EOF
load $1.mag -dereference
select top cell
extract style ngspice(si)
extract
ext2spice hierarchy on
ext2spice format ngspice
ext2spice renumber off
ext2spice scale off
ext2spice blackbox on
ext2spice subcircuit top auto
ext2spice global off
ext2spice $1.ext
quit -noprompt
EOF

