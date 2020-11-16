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

# To call: ./drc-gds-EFS8A.sh <target_path> <design_name> <pdk-root> [<output_path> default is <target_path>/results/]


export TARGET_DIR=$(pwd)
export PDK_ROOT=/ef/tech/SW/
export UTILS=~/foss/tools/sak
export MAGIC=/ef/efabless/bin/magic
export OUT_DIR=${2:-$TARGET_DIR/results}
export DESIGN_NAME=$1

if ! [[ -d "$OUT_DIR" ]]
then
    mkdir $OUT_DIR
fi
bash $UTILS/base/magic-drc.sh $TARGET_DIR $DESIGN_NAME $PDK_ROOT "gds" "EFS8A" $OUT_DIR $UTILS



#export TARGET_DIR=$1
#export PDK_ROOT=$xx
# export TCL_CALL_PATH=$UTILS/core_scripts

#bash ./base/magic-drc.sh $TARGET_DIR $DESIGN_NAME $PDK_ROOT "gds" "EFS8A" $OUT_DIR $TCL_CALL_PATH

