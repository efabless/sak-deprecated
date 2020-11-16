#!/bin/sh

export MAGTYPE=mag ;
export PDKPATH=/ef/tech/SW.2/sky130A ; 
magic -rcfile $PDKPATH/libs.tech/magic/20200508/sky130A.magicrc -dnull -noconsole << EOF

gds polygon subcell true
gds warning default

##### Import GDS then load cell in memory
gds readonly true
gds rescale false
gds read $1.gds
load $1.mag
select top cell
expand

##### generate maglef 
lef write $1.lef -hide 

# readspice $1.sp 	;# maybe we get it from cdl to enforce the correct port order
save $1 		;#saved the cell mag file from GDS -- rename or save as cell.1.mag

##### then quit magic
quit -noprompt

EOF

mv $1.mag $1.mag.mag 	;# mv the mag cell to keep it aside as mag

magic -rcfile $PDKPATH/libs.tech/magic/20200508/sky130A.magicrc -dnull -noconsole << EOX
lef read $1.lef		;# read from lef
load $1
writeall $1.lef.mag
#writeall 
quit -noprompt

EOX

#### for sky130A edit $1.mag cell find "locali" ... change it "corelocali" -

#sed 's/<< locali >>/<< corelocali >>/g' $1.mag > $1.mag.2

#### for EFS8A  do not change the locali - to - corelocali

mv $1.mag.mag $1.mag 	;# mv the mag.mag back to .mag


#magic
#load $1.mag (from lef)
## edit the layout until its DRC clean
#save $1.mag  cell.2.mag
## this generates the -----> maglef
## open the backup cell.1.mag file
## copy below into the cell.2.mag



for xmag in ./mag/efs8_pads/*.mag; 
do filename=$(basename $xmag); 
if [ -f ./maglef/efs8_pads/$filename ]; 
then xmaglef="./maglef/efs8_pads/$filename";         
echo "Modifying $xmaglef";         properties="$(sed -ne '/ properties /,$ p' $xmag | grep "GDS_")";         
while IFS= read -r prop; 
do                 
sed -i "/properties/a$prop" $xmaglef



####  << properties >>
####  string FIXED_BBOX 0 0 200 39593
####  string GDS_FILE /ef/tech/SW/EFS8A/libs.tech/openlane/custom_cells/gds/s8iom0s8_com_bus_slice_tied_1um.gds  (try ../..) relative path
####  string GDS_START 154
####  string GDS_END 6674

# open magic, open a new cell then instantiate the maglef file in the new cell.
# getcell $1.mag



# for -blackbox for lvs

# load dff.mag -force 

### to force the current technology  on theloaded cell



###from the maglef

###<< properties >>
###string LEFclass BLOCK
###string FIXED_BBOX 0 0 16000 33000
###string LEFview TRUE
###<< end >>

###from the mag

###<< properties >>
###string FIXED_BBOX 0 0 16000 33000
###string GDS_FILE /ef/tech/SW/EFS8A/libs.ref/gds/efs8_pads/efs8_pads.gds
###string GDS_END 19606640
###string GDS_START 19506986
###<< end >>







