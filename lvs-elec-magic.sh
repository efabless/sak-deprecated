#!/bin/sh

# Electric-based Schematic Netlist Generation
#elec2spi usage: 
#	[-o outputDirOrFile ] [ <options> ] libPath cellName [viewExt]  extension defaults to "sch"
#or:     [-o outputDirOrFile ] [ <options> ] libPath cellName[.viewExt]
#or:     [-o outputDirOrFile ] [ <options> ] libPath/cellName[.viewExt]


elec2spi    ;# in the ./elec as it uses the elec preferences

cd ~/design/$PROJECT/elec
elec2spi -o <output file name.sp> -LP -TS -NTI + libName.delib <cellName>.sch



# Layout Netlist Generation

/usr/local/bin/magic -dnull -noconsole << EOF
load $1
select top cell
expand
port makeall
# extract unique 		;# Turns off joinNetsByName - BY DEFAULT IT IS ON
extract all			;# ensures no incremnetal greneration of per cell .ext files
ext2spice hierarchy on
extract style ngspice(sim)	;# styles/extract: ngspice(sim) --> with subckts, ngspice(lvs) --> explicit M for transistors, ngspice(si) <<- DO NOT USE si 
ext2spice format ngspice
ext2spice scale off
ext2spice renumber off
ext2spice subcircuit top auto
ext2spice cthresh infinite
ext2spice rthresh infinite
ext2spice blackbox on
ext2spice global off
ext2spice -o $1
quit -noprompt
EOF

# Compare using Netgen

/ef/apps/bin/netgen -noconsole << EOF
readnet spice $1.spice
readnet spice $1.sp
#
lvs {$1.layout.spi <top cell name>} {$1.sch.spi <top cell name>} setup.tcl $1.lvs.report
lvs {$1.spice <top cell name>} {$1.sp <top cell name>} $PDKPATH/libs.tech/netgen/setup.tcl $1.lvs.report
quit
EOF

usage: [-o outputDirOrFile ] [ <options> ] libPath cellName [viewExt]  extension defaults to "sch"
or:    [-o outputDirOrFile ] [ <options> ] libPath cellName[.viewExt]
or:    [-o outputDirOrFile ] [ <options> ] libPath/cellName[.viewExt]



for xmag in ./mag/efs8_pads/*.mag; do
filename=$(basename $xmag)
if [ -f ./maglef/efs8_pads/$filename ]; then
        xmaglef="./maglef/efs8_pads/$filename"
        echo "Modifying $xmaglef"
        properties="$(sed -ne '/ properties /,$ p' $xmag | grep "GDS_")"
        while IFS= read -r prop; do
                sed -i "/properties/a$prop" $xmaglef
        done <<< "$properties"
fi
done


for xmag in ./mag/efs8_pads/*.mag; do
filename=$(basename $xmag)
if [ -f ./maglef/efs8_pads/$filename ]; then
        xmaglef="./maglef/efs8_pads/$filename"
        properties="$(sed -ne '/properties/,$ p' $xmag | grep "GDS_")"
        sed -i '/properties/a '"$properties"'' $xmaglef
fi
done



Options:
-X: Do post-process by cdlexpreval to simplify expressions. Too crude/simplistic, breaks if raw elec-out has .include 'blah'.
-TS: Write a subckt for the top-cell, see also -NTI (off by default)
-NTI: do NOT write an instance for the top-cell (off by default, no effect without -TS)
-P: Disables requirement that CWD has .java/.userPrefs/ dir; weakens this check to a warning.

Program is installed under two names: elec2spi, elec2cdle.
  non-cdle behavior: use preferences for both: max-line-length and SpiceEngine (typically 512 and "Spice 3").
  cdle-variant: force no-line-wrap, force SpiceEngine to SmartSpice.

Recommend using absolute path for -o argument, as well as libPath. The true electric will use
preferences (in .java/) in its current-working-dir. Due of that, wrappers and other callers of
electric typically first changeDir, forcing read of project preferences from a standardized dir.
Compared to CDL, for SPICE electric does not write a .subckt for the topcell.

By default, 'simcorners -P' (pragma-mode) post-processes raw electric-out: Make real .includes from NL-diractives for simulation.
  -NP: do not do simcorners post-processing.
  -SP: do 'simcorners -P' post-processing for simulation. This is the default.
  -LP: do 'simcorners -P -U' post-processing for LVS.






Layout Netlist Generation
          
EFS8A/EFS8A.tech: styles/extract: ngspice(sim) ngspice(lvs) ngspice(si)

all other PDKs:

EFXH018C/EFXH018C-F.tech: styles/extract: spice3(sim) spice3(lvs)


