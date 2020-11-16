#!/bin/bash
MAGTYPE=mag magic -dnull -noconsole  <<EOF
drc off
load $1.mag
select top cell
expand
lef write zcomm.lef -hide 
quit -noprompt
EOF

# cd $PDKPATH/libs.ref/mag/efs8_pads/
# for x in `ls *.mag`; do  echo $x; /home/mk/foss/tools/utils/mag2lef-mag.sh ${x%.*} ; done
# mv *.lef ../../lef/efs8_pads/
# cd ../../lef/efs8_pads/
# for x in `ls *.lef` ; do echo $x ; /home/mk/foss/tools/utils/lef2maglef-mag.sh ${x%.*} ; done
# cd ../../maglef/efs8_pads/

for xmag in ./mag/efs8_pads/*.mag; 
do filename=$(basename $xmag); 
if [ -f ./maglef/efs8_pads/$filename ]; 
then xmaglef="./maglef/efs8_pads/$filename";         
echo "Modifying $xmaglef";         properties="$(sed -ne '/ properties /,$ p' $xmag | grep "GDS_")";         
while IFS= read -r prop; 
do                 
sed -i "/properties/a$prop" $xmaglef





from the maglef

<< properties >>
string LEFclass BLOCK
string FIXED_BBOX 0 0 16000 33000
string LEFview TRUE
<< end >>

from the mag

<< properties >>
string FIXED_BBOX 0 0 16000 33000
string GDS_FILE /ef/tech/SW/EFS8A/libs.ref/gds/efs8_pads/efs8_pads.gds
string GDS_END 19606640
string GDS_START 19506986
<< end >>


for xmag in `ls mag/efs8_pads/*.mag`
do
filename=$(basename $xmag)
[[

