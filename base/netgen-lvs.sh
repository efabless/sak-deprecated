#!/bin/bash
# Copyright 2020 Efabless Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# To call: ./runLVS.sh <target directory> <design name> <spice netlist> <verilog netlist> <pdk_root> <pdk> <output directory>

export TARGET_DIR=$1
export DESIGN_NAME=$2
export SPICE_NETLIST=$3
export VERILOG_NETLIST=$4
export PDK_ROOT=$5
export PDK=$6
export OUT_DIR=$7


export RUN_ROOT=$(pwd)

if ! [[ -d "$OUT_DIR" ]]
then
    mkdir $OUT_DIR
fi

echo "Running LVS..."

setup_file=$PDK_ROOT/$PDK/libs.tech/netgen/$PDK\_setup.tcl
output=$OUT_DIR/lvs_final.log

echo "$SPICE_NETLIST against $VERILOG_NETLIST"
    
netgen -batch lvs \
    "$SPICE_NETLIST $DESIGN_NAME" \
    "$VERILOG_NETLIST $DESIGN_NAME" \
    $setup_file \
    $output \
    -json |& tee /dev/tty $OUT_DIR/lvs_inter.log

python3 $RUN_ROOT/count_lvs.py -f $OUT_DIR/lvs_final.json \
    |& tee /dev/tty $OUT_DIR/lvs_final_parsed.log
