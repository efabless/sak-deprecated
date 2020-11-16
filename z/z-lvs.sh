#!/bin/sh
/ef/apps/bin/netgen -noconsole << EOF
readnet spice $1.spice
readnet spice $1.sp
lvs {$1.spice sram_2_16_sky130} {sram_2_16_sky130.sp sram_2_16_sky130} setup.tcl sram_2_16_sky130.lvs.report
quit
EOF


#!/bin/bash
#
# Run netgen on striVe (top level)
#

NETGEN_SETUP=$PDK_ROOT/EFS8A/libs.tech/netgen/EFS8A_setup.tcl

netgen -batch lvs "../spi/openram_tc_1kb.spice openram_tc_1kb" "../verilog/gl/openram_tc_1kb.synthesis.v openram_tc_1kb" ${NETGEN_SETUP} openram_tc_1kb_comp.out -json | tee openram_tc_1kb_comp_lvs.log
