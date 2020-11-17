#!/bin/bash

: ${PDK_ROOT?"PDK_ROOT is unset"}

PADFRAME_CFG=../macros/padframe/padframe.cfg

# custom fork of padring for flipped pads
./padring \
    -L $PDK_ROOT/EFS8A/libs.ref/lef/efs8_pads/efs8_pads.lef \
    --def padframe.def $PADFRAME_CFG

# generate MAG view
MAGTYPE=mag magic -dnull -noconsole -rcfile $PDK_ROOT/EFS8A/libs.tech/magic/current/EFS8A.magicrc <<EOF
def read padframe.def
load PADRING -dereference
save padframe
exit
EOF

# Label it using information in CFG file only
# WARNING: DEF view left unlabeled
python3 label_padframe.py -pf padframe.mag -cfg $PADFRAME_CFG\
    -m 'pad/PAD'\
    -m 'vss_/VSS'\
    -m 'vdd1v8_/VDD1V8'\
    -m 'vdd3v3_/VDD3V3'\
    -m 'vddio_/VDDIO'\
    -m 'vssio_/VSSIO'

# GENERATE GDS
MAGTYPE=mag magic -dnull -noconsole -rcfile $PDK_ROOT/EFS8A/libs.tech/magic/current/EFS8A.magicrc <<EOF
gds readonly true
gds rescale false
load padframe.mag -dereference
gds write padframe.gds
EOF


# GENERATE LEF and SPICE
MAGTYPE=maglef magic -dnull -noconsole -rcfile $PDK_ROOT/EFS8A/libs.tech/magic/current/EFS8A.magicrc <<EOF
load padframe.mag -dereference
select top cell

extract do local
extract no capacitance
extract no coupling
extract no resistance
extract no adjust

extract
ext2spice lvs
ext2spice

lef write padframe.lef
exit
EOF

rm -f ./*.ext
cp padframe.* ../macros/padframe/
mv padframe.spice ../spi
mv padframe.def ../def
mv padframe.mag ../mag
mv padframe.gds ../gds
mv padframe.lef ../lef
