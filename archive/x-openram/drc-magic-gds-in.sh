#!/bin/sh
export MAGTYPE=mag ;export PDKPATH=/ef/tech/SW.2/sky130A ; magic -rcfile $PDKPATH/libs.tech/magic/20200508/sky130A.magicrc -dnull -noconsole << EOF
gds polygon subcell true
gds warning default
gds readonly false
###############gds readonly true
gds read $1.gds
load $1
save
select top cell
expand
drc on
drc euclidean on
drc style drc(full)
drc check
drc catchup
save $1.drc.mag
#############puts [drc listall why]
drc count total
drc count
EOF
