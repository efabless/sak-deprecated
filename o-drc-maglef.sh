#!/bin/bash
export MAGTYPE=maglef; 
export PDKPATH=/ef/tech/SW/EFS8A ; 
magic -dnull -noconsole -rcfile $PDKPATH/libs.tech/magic/20200408/EFS8A.magicrc  <<EOF

echo $MAGTYPE
drc off
load  $1.mag -dereference
select top cell
expand
drc style drc(full)
drc euclidean on
drc check
drc catchup
drc count total
drc count
drc list count
quit -noprompts

EOF
