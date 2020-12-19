#!/bin/bash
export MAGIC=//ef/apps/ocd/magic/8.3.83-202011161629/bin/magic
export MAGTYPE=mag; export PDKPATH=/ef/tech/SW/EFS8A ; $MAGIC -dnull -noconsole -rcfile $PDKPATH/libs.tech/magic/20200408/EFS8A.magicrc  <<EOF

drc off				;# don't run continuous backgruond DRC checks
#gds polygon subcell true
gds flatten true
gds warning default
gds readonly true
tech unlock *
gds read $1
cellname delete \(UNNAMED\)
load $2
select top cell
#writeall force 
#select top cell
#expand
port makeall
##########
extract unique 			;# Turns off joinNetsByName - BY DEFAULT IT IS ON
extract style ngspice(sim)	;# styles/extract: ngspice(sim) --> with subckts, ngspice(lvs) --> explicit M for transistors, ngspice(si) <<- DO NOT USE si 
extract do local		;# where to dump the *.ext --> local ./ - only use with gds read 
extract no all			;# do not do parasitics
extract all			;# ensures no incremnetal greneration of per cell .ext files
feedback save $2.ext.tcl
##########
#ext2spice lvs			;# = all the steps commented below
ext2spice hierarchy on		;#
ext2spice format ngspice
ext2spice scale on		;#
ext2spice renumber off		;# renumbers the subcircuit instances
ext2spice subcircuit top auto	;# add .subckt for the top cell
ext2spice cthresh infinite
ext2spice rthresh infinite
ext2spice blackbox on		;# detects MAGTYPE=maglef files and netlists them as blackbox
ext2spice global off
#ext2spice -o $2.spice
ext2spice			;# generates *.spice from *.ext
##########
##########
##########
load $3
select top cell
#writeall force 
#select top cell
#expand
port makeall
##########
extract unique 			;# Turns off joinNetsByName - BY DEFAULT IT IS ON
extract style ngspice(sim)	;# styles/extract: ngspice(sim) --> with subckts, ngspice(lvs) --> explicit M for transistors, ngspice(si) <<- DO NOT USE si 
extract do local		;# where to dump the *.ext --> local ./ - only use with gds read 
extract no all			;# do not do parasitics
extract all			;# ensures no incremnetal greneration of per cell .ext files
feedback save $3.ext.tcl
##########
#ext2spice lvs			;# = all the steps commented below
ext2spice hierarchy on		;#
ext2spice format ngspice
ext2spice scale on		;#
ext2spice renumber off		;# renumbers the subcircuit instances
ext2spice subcircuit top auto	;# add .subckt for the top cell
ext2spice cthresh infinite
ext2spice rthresh infinite
ext2spice blackbox on		;# detects MAGTYPE=maglef files and netlists them as blackbox
ext2spice global off
#ext2spice -o $3.spice
ext2spice			;# generates *.spice from *.ext
##########
quit -noprompt

EOF

\rm -f *.ext
