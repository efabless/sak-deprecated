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

# To call: ./gds-netgen-lvs-sky130A.sh <target_path> <design_name> <spice netlist> <verilog netlist> <pdk-root> [<output_path> default is <target_path>/results/]

export TARGET_DIR=$1
export DESIGN_NAME=$2
export SPICE_NETLIST=$3
export VERILOG_NETLIST=$4
export PDK_ROOT=$5
export OUT_DIR=${6:-$TARGET_DIR/results/}

if ! [[ -d "$OUT_DIR" ]]
then
    mkdir $OUT_DIR
fi

bash ./base/netgen-lvs.sh $TARGET_DIR $DESIGN_NAME $SPICE_NETLIST $VERILOG_NETLIST $PDK_ROOT "EFS8A" $OUT_DIR
