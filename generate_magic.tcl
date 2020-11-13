#!/usr/bin/env wish
#--------------------------------------------
# Script to generate .mag files from .gds    
#--------------------------------------------
gds readonly true
gds flatten true
tech unlock *
gds read /ef/tech/SW/EFS8A/libs.ref/gds/efs8_pads/efs8_pads.gds
cellname delete \(UNNAMED\)
writeall force
puts stdout "Done."
quit -noprompt
