#!/bin/sh

export MAGTYPE=mag ;
export PDKPATH=/ef/tech/SW.2/sky130A ; 
magic -rcfile $PDKPATH/libs.tech/magic/20200508/sky130A.magicrc -dnull -noconsole << EOF

gds polygon subcell true
gds warning default

##### generate maglef 

gds readonly true
gds rescale false
gds read $1.gds
load $1
# readspice $1.sp 	;# maybe we get it from cdl to enforce the correct port order

save $1 		;# saved the cell mag file from GDS -- rename or save as cell.1.mag

#### write lef file

lef write 		;# $1.lef

##### then quit magic

## mv the mag cell to keep it aside as mag
open magic
lef read $1.lef
load $1
writeall
## that wrote a new cell.mag file only from lef
quit

#### for sky130A 
# edit $1.mag cell find "locali" ... change it "corelocali" -


### for EFS8A
## do not do the locali - to - corelocali

magic
load $1.mag (from lef)
## edit the layout until its DRC clean
save $1.mag  cell.2.mag
## this generates the -----> maglef
## open the backup cell.1.mag file
## copy below into the cell.2.mag

####  << properties >>
####  string FIXED_BBOX 0 0 200 39593
####  string GDS_FILE /ef/tech/SW/EFS8A/libs.tech/openlane/custom_cells/gds/s8iom0s8_com_bus_slice_tied_1um.gds  (try ../..) relative path
####  string GDS_START 154
####  string GDS_END 6674

open magic, open a new cell then instantiate the maglef file in the new cell.

getcell $1.mag


for -blackbox for lvs

load dff.mag -force 
### to force the current technology  on theloaded cell

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
