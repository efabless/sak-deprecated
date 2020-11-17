#!/bin/bash

export MAGTYPE=maglef ;
export BASE=/home/mk/zooz/ ;
export PDKPATH=$BASE/pdks/ef-skywater-s8/EFS8A ;

magic -dnull -noconsole -rcfile $PDKPATH/libs.tech/magic/current/EFS8A.magicrc <<EOF
gds polygon subcell true
gds warning default
gds read $1.gds
load $1.mag
save $1.mag
writeall force???
##########
select top cell
expand
port makeall
##########
extract unique 			;# Turns off joinNetsByName - BY DEFAULT IT IS ON
extract style ngspice(sim)	;# styles/extract: ngspice(sim) --> with subckts, ngspice(lvs) --> explicit M for transistors, ngspice(si) <<- DO NOT USE si 
extract all			;# ensures no incremnetal greneration of per cell .ext files
feedback save ${1%.mag}.ext.tcl
##########
ext2spice hierarchy on		;#
ext2spice format ngspice
ext2spice scale on		;#
ext2spice renumber off		;# renumbers the subcircuit instances
ext2spice subcircuit top auto
ext2spice cthresh infinite
ext2spice rthresh infinite
ext2spice blackbox on		;# detects MAGTYPE=maglef files and netlists them as blackbox
ext2spice global off
ext2spice -o ${1%.mag}.spice
##########
quit -noprompt
EOF

# source s8iom0s8_top_power_hvc_wpad.ext.log
# snap int
# select area metal2

