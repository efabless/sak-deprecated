#!/bin/bash
MAGTYPE=mag magic -dnull -noconsole  <<EOF
drc off
load $1.mag
select top cell
expand
lef write $1.lef -hide 
quit -noprompt
EOF

