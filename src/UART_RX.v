/*
very simple UART module
Michal Stankiewicz, 21.02.2022
*/

module UART_RX
	(
		input CLK,
		input RESET,
		input RX,
		output reg[7:0] DATA,
		output reg NEW_DATA
	);
	
	parameter wait_period = 1250;  // number of clock cycles per 1 baud
	parameter[3:0] idle=4'd0, bit_0=4'd1, bit_1=4'd2, bit_2=4'd3, bit_3=4'd4, bit_4=4'd5, bit_5=4'd6, bit_6=4'd7, bit_7=4'd8, output_data=4'd9;  
	
	integer counter = 0;
	integer timer = 0;
	
	reg[3:0] state = 0;
	reg[3:0] next_state = 0;
	
	reg [7:0] data_rx;
	reg enable_rx;
	reg[3:0] edge_buff = 4'b1111;
	
	always @ (posedge CLK)  // edge detector
	begin
		edge_buff <= {edge_buff[2:0], RX};
		if(edge_buff == 4'b1100)
			enable_rx <= 1;
		else if(state == output_data)
			enable_rx <= 0;
	end	
	
	always @ (posedge CLK)  // state update 
	begin
		if(RESET == 1)
		begin
			state <= idle;
		end else
		begin
			counter <= counter + 1;	 // timed FSM
			if(timer <= counter)
			begin
				state <= next_state;
				counter <= 0;
			end	
		end
	end
		
	always @(*)  // next state
	begin
		case(state)		
			idle:
			begin
				if(enable_rx == 1)
				begin
					next_state = bit_0;
					timer = wait_period * 3/2;
				end else
				begin
					next_state = idle;
					timer = 0;
				end
			end
			
			bit_0:
			begin
				timer = wait_period;
				next_state = bit_1;
			end
			
			bit_1: 
			begin
				timer = wait_period;  
				next_state = bit_2; 
			end
								  
			bit_2:
			begin
				timer = wait_period;  
				next_state = bit_3; 
			end
								  
			bit_3:
			begin
				timer = wait_period;  
				next_state = bit_4; 
			end
								  
			bit_4:
			begin
				timer = wait_period;  
				next_state = bit_5;  
			end
								  
			bit_5:
			begin
				timer = wait_period;  
				next_state = bit_6; 
			end
								  
			bit_6:
			begin
				timer = wait_period;  
				next_state = bit_7;   
			end
								  
			bit_7:
			begin
				timer = wait_period;
				next_state = output_data;
			end
			
			output_data:  
			begin
				timer = 0;
				next_state = idle; 
			end
		endcase
	end

	
	
	always @(*)	 // output update
	begin
		case(state)		
			idle:
			begin
				NEW_DATA = 0;
			end
			
			bit_0:
			begin
				if(counter == 0)
					data_rx[0] = RX;
				NEW_DATA = 0;
			end
			
			bit_1: 
			begin
				if(counter == 0)
					data_rx[1] = RX;
				NEW_DATA = 0; 
			end
								  
			bit_2:
			begin
				if(counter == 0)
					data_rx[2] = RX;
				NEW_DATA = 0; 
			end
								  
			bit_3:
			begin
				if(counter == 0)
					data_rx[3] = RX;
				NEW_DATA = 0; 
			end
								  
			bit_4:
			begin
				if(counter == 0)
					data_rx[4] = RX;
				NEW_DATA = 0;  
			end
								  
			bit_5:
			begin
				if(counter == 0)
					data_rx[5] = RX;
				NEW_DATA = 0; 
			end
								  
			bit_6:
			begin
				if(counter == 0)
					data_rx[6] = RX;
				NEW_DATA = 0;   
			end
								  
			bit_7:
			begin
				if(counter == 0)
					data_rx[7] = RX;
				NEW_DATA = 0;
			end
			
			output_data:  
			begin
				NEW_DATA = 1;
				DATA <= data_rx;
			end
		endcase
	end
	
endmodule