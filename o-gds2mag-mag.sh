#!/bin/sh
export MAGTYPE=mag  ; 
export PDKPATH=/ef/tech/SW/EFS8A ; 
/ef/apps/ocd/magic/dev/bin/magic -rcfile $PDKPATH/libs.tech/magic/current/EFS8A.magicrc -dnull -noconsole << EOF

drc off
#gds polygon subcell true
gds warning default
gds readonly true
gds rescale false
#tech unlock *
gds read $1
load ${1%.gds}
#readspice ${1%.gds}.sp
#cellname delete "(UNNAMED)"
writeall force
lef write -hide
quit -noprompt
EOF
