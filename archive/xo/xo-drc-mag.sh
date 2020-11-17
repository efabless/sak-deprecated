#!/bin/bash
export MAGIC=/ef/apps/ocd/magic/8.3.67-202010151618/bin/magic
export MAGTYPE=mag; 
export PDKPATH=/ef/tech/SW/EFS8A ; 
$MAGIC -dnull -noconsole -rcfile $PDKPATH/libs.tech/magic/20200408/EFS8A.magicrc  <<EOF

echo $MAGTYPE
drc off					;# drc on --> only needed for on-the-fly-drc not needed if "drc check" is used
load  $1.mag -dereference
select top cell
#expand

drc style drc(full)			;# 
drc euclidean on
drc check				;# start checking DRC in the background
drc catchup				;# wait until the background DRC run is finished
drc listall why				;# No errors found.
drc list why				;# No errors found.
drc count total		  		;# Total DRC errors found: 3828
# 					;# Cell zcomm has 3828 error tiles.
quit -noprompts
EOF

# export MAGTYPE=mag; export PDKPATH=/ef/tech/SW/EFS8A ; /ef/apps/ocd/magic/dev/bin/magic -dnull -noconsole -rcfile $PDKPATH/libs.tech/magic/20200408/EFS8A.magicrc  <<EOF
# export MAGTYPE=mag; export PDKPATH=/ef/tech/SW/EFS8A ; /ef/apps/ocd/magic/8.3.61-202009260239/bin/magic -dnull -noconsole -rcfile $PDKPATH/libs.tech/magic/20200408/EFS8A.magicrc  <<EOF
