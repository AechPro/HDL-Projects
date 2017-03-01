# Dr. Kaputa
# Quartus II compile script for DE1-SoC board

# 1] name your project here
set project_name "add_sub_machine"

file delete -force project
file delete -force output_files
file mkdir project
cd project
load_package flow
project_new $project_name
set_global_assignment -name FAMILY Cyclone
set_global_assignment -name DEVICE 5CSEMA5F31C6 
set_global_assignment -name TOP_LEVEL_ENTITY top
set_global_assignment -name PROJECT_OUTPUT_DIRECTORY ../output_files

# 2] include your relative path files here
set_global_assignment -name VHDL_FILE ../../src/generic_adder_beh.vhd
set_global_assignment -name VHDL_FILE ../../src/seven_seg.vhd
set_global_assignment -name VHDL_FILE ../../src/generic_counter.vhd
set_global_assignment -name VHDL_FILE ../../src/generic_subtractor_beh.vhd
set_global_assignment -name VHDL_FILE ../../src/top.vhd

set_location_assignment PIN_AB12 -to reset
set_location_assignment PIN_AF14 -to clk
#set_location_assignment PIN_D25 -to clk

set_location_assignment PIN_AF9  -to input_a[0]
set_location_assignment PIN_AF10 -to input_a[1]
set_location_assignment PIN_AD11 -to input_a[2]
set_location_assignment PIN_AD12 -to input_b[0]
set_location_assignment PIN_AE11 -to input_b[1]
set_location_assignment PIN_AC9  -to input_b[2]

set_location_assignment PIN_AE26 -to display_one[0]
set_location_assignment PIN_AE27 -to display_one[1]
set_location_assignment PIN_AE28 -to display_one[2]
set_location_assignment PIN_AG27 -to display_one[3]
set_location_assignment PIN_AF28 -to display_one[4]
set_location_assignment PIN_AG28 -to display_one[5]
set_location_assignment PIN_AH28 -to display_one[6]

set_location_assignment PIN_AJ29 -to display_two[0]
set_location_assignment PIN_AH29 -to display_two[1]
set_location_assignment PIN_AH30 -to display_two[2]
set_location_assignment PIN_AG30 -to display_two[3]
set_location_assignment PIN_AF29 -to display_two[4]
set_location_assignment PIN_AF30 -to display_two[5]
set_location_assignment PIN_AD27 -to display_two[6]

set_location_assignment PIN_AB23 -to display_three[0]
set_location_assignment PIN_AE29 -to display_three[1]
set_location_assignment PIN_AD29 -to display_three[2]
set_location_assignment PIN_AC28 -to display_three[3]
set_location_assignment PIN_AD30 -to display_three[4]
set_location_assignment PIN_AC29 -to display_three[5]
set_location_assignment PIN_AC30 -to display_three[6]

# set_location_assignment PIN_AD26 -to bcd_3[0]
# set_location_assignment PIN_AC27 -to bcd_3[1]
# set_location_assignment PIN_AD25 -to bcd_3[2]
# set_location_assignment PIN_AC25 -to bcd_3[3]
# set_location_assignment PIN_AB28 -to bcd_3[4]
# set_location_assignment PIN_AB25 -to bcd_3[5]
# set_location_assignment PIN_AB22 -to bcd_3[6]

# set_location_assignment PIN_AA24 -to bcd_4[0]
# set_location_assignment PIN_Y23  -to bcd_4[1]
# set_location_assignment PIN_Y24  -to bcd_4[2]
# set_location_assignment PIN_W22  -to bcd_4[3]
# set_location_assignment PIN_W24  -to bcd_4[4]
# set_location_assignment PIN_V23  -to bcd_4[5]
# set_location_assignment PIN_W25  -to bcd_4[6]

# set_location_assignment PIN_V25  -to bcd_5[0]
# set_location_assignment PIN_AA28 -to bcd_5[1]
# set_location_assignment PIN_Y27  -to bcd_5[2]
# set_location_assignment PIN_AB27 -to bcd_5[3]
# set_location_assignment PIN_AB26 -to bcd_5[4]
# set_location_assignment PIN_AA26 -to bcd_5[5]
# set_location_assignment PIN_AA25 -to bcd_5[6]

set_location_assignment PIN_AA14 -to add_button

execute_flow -compile
project_close