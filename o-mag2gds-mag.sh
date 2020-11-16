#!/bin/bash
MAGTYPE=mag magic -dnull -noconsole  <<EOF
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
