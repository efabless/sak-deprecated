#!/bin/sh
# $1 cell_1rw_1r
\rm $1.mag* $1.lef
export MAGTYPE=mag ;export PDKPATH=/ef/tech/SW.2/sky130A ; magic -rcfile $PDKPATH/libs.tech/magic/20200508/sky130A.magicrc -dnull -noconsole << EOF
gds polygon subcell true
gds warning default
##### generate maglef for cell_1rw_1r
gds readonly true
gds rescale false
gds read $1.gds
load $1
readspice $1.sp
writeall 1$
lef write
quit
EOF
mv $1.mag $1.mag.1

export MAGTYPE=mag ;export PDKPATH=/ef/tech/SW.2/sky130A ; magic -rcfile $PDKPATH/libs.tech/magic/20200508/sky130A.magicrc -dnull -noconsole << EOX
lef read $1.lef
load $1
writeall
select top cell
expand
drc on
drc euclidean on
drc style drc(full)
drc check
drc catchup
save
quit
EOX

sed 's/<< locali >>/<< corelocali >>/g' $1.mag > $1.mag.2
\mv $1.mag.2 $1.mag

