#!/bin/bash

# SLAVEs
iverilog -g2005-sv -o ./TEST/VVP/apb_exe_unit_1.vvp ./MODEL/apb_exe_unit_1/apb_exe_unit_1.sv
iverilog -g2005-sv -o ./TEST/VVP/apb_exe_unit_2.vvp ./MODEL/apb_exe_unit_2/apb_exe_unit_2.sv
iverilog -g2005-sv -o ./TEST/VVP/apb_exe_unit_3.vvp ./MODEL/apb_exe_unit_3/apb_exe_unit_3.sv

# SLAVEs TB
iverilog -g2005-sv -o ./TEST/VVP/tb_apb_exe_unit_1.vvp ./TEST/tb_apb_exe_unit_1.sv
vvp ./TEST/VVP/tb_apb_exe_unit_1.vvp   

iverilog -g2005-sv -o ./TEST/VVP/tb_apb_exe_unit_2.vvp ./TEST/tb_apb_exe_unit_2.sv
vvp ./TEST/VVP/tb_apb_exe_unit_2.vvp   

iverilog -g2005-sv -o ./TEST/VVP/tb_apb_exe_unit_3.vvp ./TEST/tb_apb_exe_unit_3.sv
vvp ./TEST/VVP/tb_apb_exe_unit_3.vvp   