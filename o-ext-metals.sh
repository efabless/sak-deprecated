#!/bin/bash

export MAGTYPE=mag  ; export PDKPATH=/ef/tech/SW/EFS8A ; /ef/apps/ocd/magic/dev/bin/magic -rcfile $PDKPATH/libs.tech/magic/current/EFS8A.magicrc  -dnull -noconsole -rcfile $PDKPATH/libs.tech/magic/current/EFS8A.magicrc <<EOF

#########
load $1.mag -dereference
select top cell
expand
port makeall
#########
extract style ngspice(sim)	;# styles/extract: ngspice(sim) --> with subckts, ngspice(lvs) --> explicit M for transistors, ngspice(si) <<- DO NOT USE si 
extract unique 			;# Turns off joinNetsByName - BY DEFAULT IT IS ON
extract all			;# ensures no incremnetal greneration of per cell .ext files
#########
ext2spice hierarchy on
ext2spice format ngspice
ext2spice cthresh 0
ext2spice rthresh 0
ext2spice renumber off
ext2spice scale off
ext2spice -y 10
ext2spice blackbox on
ext2spice subcircuit top auto
ext2spice global off
ext2spice $1.ext
quit -noprompt
EOF
