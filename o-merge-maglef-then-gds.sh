#!/bin/bash

export MAGTYPE=maglef 
export PDKPATH=/ef/tech/SW/EFS8A 
magic -rcfile $PDKPATH/libs.tech/magic/20200408/EFS8A.magicrc -dnull -noconsole $1 << EOF

getcell $2.mag
select top cell  
move origin -750um -1000um
box position 0 0 ; 
getcell $3.mag
writeall force $1
select top cell
expand
cif *hier write disable
cif *array write disable
gds write $1.gds
quit
EOF
