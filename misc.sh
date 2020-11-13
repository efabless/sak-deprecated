
#!/bin/bash
 -dnull -noconsole -rcfile $PDKPATH/libs.tech/magic/current/EFS8A.magicrc  <<EOF
echo $MAGTYPE
load  $1.mag -dereference
select top cell
expand
drc on
drc style(full)
drc euclidean on
drc check
drc catchup
drc listall 
drc listall why
drc count total
drc count
quit -noprompts
EOF










#!/bin/bash

export MAGTYPE=maglef ;
export BASE=/home/mk/zooz/ ;
export PDKPATH=$BASE/pdks/ef-skywater-s8/EFS8A ;

magic -dnull -noconsole -rcfile $PDKPATH/libs.tech/magic/current/EFS8A.magicrc <<EOF
gds polygon subcell true
gds warning default






#!/bin/bash
magic -dnull -noconsole  <<EOF
echo $MAGTYPE
load  $1.mag -dereference
select top cell
expand
cif *hier write disable
cif *array write disable
gds write $1.gds
quit -noprompt
EOF
ls $1.gds
klayout $1.gds




drc off
gds readonly true
gds read ../gds/temp_top.gds
load temp_top
select top cell
writeall force temp_top.mag


lef read $1.lef
load $1
select top cell
writeall force


MAGTYPE=maglef
lmagic fasoc_temp_top
getcell temp_top.mag
select top cell  
move origin -750um -1000um
box position 0 0 ; 
getcell advSeal_6um_gen_1.mag
writeall force fasoc_temp_top
quit

lmagic fasoc_temp_top
select top cell
expand
cif *hier write disable
cif *array write disable
gds write fasoc_temp_top.gds
quit



set ::env(MAGTYPE) mag
load  <ctop-ell-name>.mag -dereference
select top cell
expand
gfgds write <top-cell-name>.gds






set ::env(MAGTYPE) mag
load  lmi814A_22oct2020.mag -dereference
select top cell
expand
cif *hier write disable
cif *array write disable
gds write fasoc_temp_top.gds




lmi_reticle_tile_20201109_18:55.gds
load  lmi_reticle_tile.mag
cellname delete lmi814A_22oct2020
cellname delete lmi814B_22oct2020
select top cell
writeall force




expand
drc on
drc style(full)
drc euclidean on
drc check
drc catchup
drc listall 
drc listall why
drc count total
drc count
quit -noprompt
EOF
