create_clock -period 3.000 -name STU1 [get_pins DL_3/click_inferred_i_1/O]
set_disable_timing -from I0 -to O [get_cells DL_3/phase_in_i_1]
set_disable_timing -from I0 -to O [get_cells DL_3/phase_out_i_1]
create_generated_clock -name STU1_1 -source [get_pins DL_3/phase_out_reg/C] -divide_by 1 -add -master_clock STU1 [get_pins DL_3/phase_out_reg/Q]
set_disable_timing -from I0 -to O [get_cells DL_4/phase_in_i_1]
set_disable_timing -from I0 -to O [get_cells DL_4/phase_out_i_1]
set_clock_groups -asynchronous -group {STU1 STU1_1}
set_clock_sense -positive [get_pins DL_3/click_inferred_i_1/O]
set_clock_sense -positive [get_pins DL_4/click_inferred_i_1/O]
set_multicycle_path -setup -to [all_clocks] 0
