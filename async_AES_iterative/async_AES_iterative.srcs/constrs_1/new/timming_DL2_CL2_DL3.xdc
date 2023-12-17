#DL4_CL2_DL3

reset_timing

create_clock -name STU1 -period 3 [get_pins DL_2/click_inferred_i_1/O]


set_disable_timing -from I0 -to O [get_cells DL_2/phase_in_i_1]
set_disable_timing -from I0 -to O [get_cells DL_2/phase_out_i_1]

create_generated_clock -name STU1_1 -divide_by 1 -source [get_pins DL_2/phase_out_reg/C] [get_pins DL_2/phase_out_reg/Q] -master STU1 -add

set_disable_timing -from I0 -to O [get_cells DL_3/phase_in_i_1]
set_disable_timing -from I0 -to O [get_cells DL_3/phase_out_i_1]

set_clock_groups -asynchronous -group {STU1 STU1_1}

set_clock_sense -positive [get_pins DL_2/click_inferred_i_1/O]
set_clock_sense -positive [get_pins DL_3/click_inferred_i_1/O]

set_multicycle_path 0  -setup -to [all_clocks]
report_timing -setup -no_report_unconstrained -file "D:\\Circuit\\AES\\async_AES_iterative\\setup_DL2_CL2_DL3.rpt"