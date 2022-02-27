/*
testbench for UART_RX module
Michal Stankiewicz 21.02.2022
*/ 
`timescale 1ns/1ps

module UART_RX_tb;
	localparam baud_duration = 104166.667;  // 104166.667 ns
	
	reg CLK;
	reg RESET;
	reg RX;
	wire[7:0] DATA;
	wire NEW_DATA;
	
	initial CLK = 1;
	always #41.666 CLK = ~CLK;
	
	// 1250 for baud rate 9600
	UART_RX #(.wait_period(1250)) UUT(.CLK(CLK), .RESET(RESET), .RX(RX), .DATA(DATA), .NEW_DATA(NEW_DATA));
	
	assign RESET = 0;
	
	initial
	begin
		RX = 1;
		#baud_duration;
		RX = 0; // start bit;
		#baud_duration
		RX = 1;  // bit 0
		#baud_duration;
		RX = 1;  // bit 1
		#baud_duration;
		RX = 0;  // bit 2
		#baud_duration;
		RX = 0;  // bit 3
		#baud_duration;
		RX = 1;  // bit 4
		#baud_duration;
		RX = 0;  // bit 5
		#baud_duration;
		RX = 1;  // bit 6
		#baud_duration;
		RX = 0;  // bit 7
		#baud_duration;
		RX = 1;  // stop bit
		
	end
	
endmodule
