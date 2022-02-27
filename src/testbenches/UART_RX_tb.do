SetActiveLib -UART
asim +access +r UART_RX_tb 
wave
wave -noreg CLK
wave -noreg RESET	 
wave -noreg RX	
wave -noreg DATA
wave -noreg NEW_DATA
wave -noreg /UART_RX_tb/UUT/state 
wave -noreg /UART_RX_tb/UUT/next_state
wave -noreg /UART_RX_tb/UUT/counter

run 2000000.00 ns
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\tutorvhdl_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_tutorvhdl 