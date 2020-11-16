#!/bin/sh

export MAGTYPE=mag export PDKPATH=/ef/tech/SW/EFS8A  magic -rcfile $PDKPATH/libs.tech/magic/20200408/EFS8A.magicrc -dnull -noconsole << EOF

gds warning default

gds readonly true
gds rescale false
gds read $1.gds
load $1
#readspice $1.sp
lef write -hide
quit
EOF
mv $1.mag $1.mag.1

export MAGTYPE=mag export PDKPATH=/ef/tech/SW/EFS8A  magic -rcfile $PDKPATH/libs.tech/magic/20200408/EFS8A.magicrc -dnull -noconsole << EOX
lef read $1.lef
load $1
writeall $1.maglef
quit
EOX
