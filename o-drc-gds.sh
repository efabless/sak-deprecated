#!/bin/bash

export MAGTYPE=mag ;
export PDK=EFS8A;
export GDS_FILE_NAME=$1
export CELL_NAME=$2
export PDK_ROOT=/ef/tech/SW/
export PDKPATH=$PDK_ROOT/$PDK
export MAGIC=/ef/efabless/bin/magic

$MAGIC -dnull -noconsole -rcfile $PDKPATH/libs.tech/magic/current/EFS8A.magicrc <<EOF
gds polygon subcell true
gds warning default
gds readonly true
gds read $GDS_FILE_NAME
load $CELL_NAME
cellname delete \(UNNAMED\)
select top cell
expand
drc on
drc style drc(full)			
drc euclidean on
#drc check		;# Is it really needed?
#drc catchup		;# Is it really needed?
drc listall why
drc count total
drc count
quit -noprompt
EOF



