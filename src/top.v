/*
top module
*/

module top
	(
	input CLK,
	input RX,
	output wire[7:0] DATA
	);
	
	wire new_data;
	
	UART_RX #(.wait_period(1250)) uart(.CLK(CLK), .RESET(0), .RX(RX), .DATA(DATA), .NEW_DATA(new_data));
	
endmodule