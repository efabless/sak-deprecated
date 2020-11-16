#!/bin/sh
export BASE=/home/mk/foss
grep -f $BASE/tools/utils/s130.drc.rules drc/$1.drc.summary | grep -v "    RULECHECK" | awk '{print $2", " $(NF-1)", "$NF}' | sed 's/(//g' | sed 's/)//g' | sort -k 1
