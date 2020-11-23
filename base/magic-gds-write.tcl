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

puts "Performing GDS Streaming Out..."

set ::env(MAGIC_PAD) 0
set ::env(MAGIC_ZEROIZE_ORIGIN) 1
set ::env(MAGTYPE) mag

if { ![file isdirectory $::env(OUT_DIR)] } {
	exec mkdir $::env(OUT_DIR)/
}


if { $::env(TARGET_TYPE) == "gds"} {
	gds read $::env(TARGET_DIR)/$::env(DESIGN_NAME).gds
} else {
	if { $::env(TARGET_TYPE) == "mag" } {
		load $::env(TARGET_DIR)/$::env(DESIGN_NAME).mag
	} else {
		def read $::env(TARGET_DIR)/$::env(DESIGN_NAME).def
	}
}

drc off

gds readonly true
gds rescale false

load $::env(DESIGN_NAME)
select top cell

# padding

if { $::env(MAGIC_PAD) } {
	puts "\[INFO\]: Padding LEFs"
	# assuming scalegrid 1 2
	# use um
	select top cell
	box grow right [expr 100*($::env(PLACE_SITE_WIDTH))]
	box grow left [expr 100*($::env(PLACE_SITE_WIDTH))]
	box grow up [expr 100*($::env(PLACE_SITE_HEIGHT))]
	box grow down [expr 100*($::env(PLACE_SITE_HEIGHT))]
	property FIXED_BBOX [box values]
}
if { $::env(MAGIC_ZEROIZE_ORIGIN) } {
	# assuming scalegrid 1 2
	# makes origin zero based on the selection
	puts "\[INFO\]: Zeroizing Origin"
	set bbox [box values]
	set offset_x [lindex $bbox 0]
	set offset_y [lindex $bbox 1]
	move origin [expr {$offset_x/2}] [expr {$offset_y/2}]
	puts "\[INFO\]: Current Box Values: [box values]"
	property FIXED_BBOX [box values]
}

select top cell

# Write gds
cif *hier write disable
gds write $::env(OUT_DIR)/$::env(DESIGN_NAME).gds
puts "\[INFO\]: GDS Write Complete"
