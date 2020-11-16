#!/bin/bash
MAGTYPE=mag magic  -dnull -noconsole -rcfile /ef/tech/SW/EFS8A/libs.tech/magic/20200408/EFS8A.magicrc <<EOF
drc off
save delete.mag
lef read $1.lef
cellname list allcells
puts $1
select top cell
expand
writeall force
quit -noprompt
EOF
\rm delete.mag -f


#foreach cell [cellname list allcells] {
#	puts "$cell"
#	load $cell
#	select top cell
#	expand
#	save $cell.mag
#}
