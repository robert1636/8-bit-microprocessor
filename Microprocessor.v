`timescale 1ns/1ps
//`include "pb_debouncing.v"
//`include "deb.v"
module debounce(input pb_1,clk,output pb_out);
	wire slow_clk_en;
	wire Q1,Q2,Q2_bar;
	clock_enable u1(clk,pb_1,slow_clk_en);
	my_dff_en d1(clk,slow_clk_en,pb_1,Q1);
	my_dff_en d2(clk,slow_clk_en,Q1,Q2);
assign Q2_bar = ~Q2;
assign pb_out = Q1 & Q2_bar;

//always @(Q1 or Q2_bar) begin
//	$display($time, "Q1 = %d, Q2_bar = %d", Q1, Q2_bar);
//end

//always @(pb_out) begin
//	$display($time, "pb_out = %d", pb_out);
//end

//always @ (pb_1) begin
//	$display($time, "microprocessor::pb_1 = %d", pb_1);
//end

endmodule
// Slow clock enable for debouncing button 
module clock_enable(input Clk_100M,pb_1, output slow_clk_en);
    reg [26:0]counter=0;
    always @(posedge Clk_100M, negedge pb_1)
    begin
     if(pb_1==0)
              counter <= 0;
            else
       counter <= (counter>=2)?0:counter+1;
    end
    assign slow_clk_en = (counter == 2)?1'b1:1'b0;
	 
//	 always @ (slow_clk_en) begin
//		$display("slow_clk_en = %d", slow_clk_en);
//	 end
endmodule
// D-flip-flop with clock enable signal for debouncing module 
module my_dff_en(input DFF_CLOCK, clock_enable,D, output reg Q=0);
    always @ (posedge DFF_CLOCK) begin
		//$display("clock_enable = %d", clock_enable);
  if(clock_enable==1) 
           Q <= D;
			  //$display("Q = %d", Q);
    end
endmodule 


module microprocessor(
	output reg [7:0] data_out, //8-bit output leds
	input [7:0] data_in,//4-bit source 1 + 4-bit source 2
	input [2:0] pb,//3-bit op code sourced from buttons
	input rst, //1-bit reset
	output [2:0] opcode,
	output [2:0] button,
	input clk
);

//wire clk;
//assign clk = CLK100MHZ;
//initial begin
//  clk = 0;
//  forever #10 clk = ~clk;
// end
 
reg [2:0] opcode = 3'b000;
wire [2:0] button;
//push button debouncing 

debounce b1(.pb_1(pb[0]),.clk(clk),.pb_out(button[0]));
debounce b2(.pb_1(pb[1]),.clk(clk),.pb_out(button[1]));
debounce b3(.pb_1(pb[2]),.clk(clk),.pb_out(button[2]));

//always @ (pb[0]) begin
//	debounce b1(pb[0],clk,button[0]);
//end
//
//always @ (pb[1]) begin
//	debounce b2(pb[1],clk,button[1]);
//end
//
//always @ (pb[2]) begin
//	debounce b3(pb[2],clk,button[2]);
//end
//push button debouncing end	 
	 




//each time one button is pressed, toggle the state of the corresponding bit in opcode
always @ (posedge button[0]) begin
	opcode[0] = ~opcode[0];
end

always @ (posedge button[1]) begin
	opcode[1] = ~opcode[1];
end

always @ (posedge button[2]) begin
	opcode[2] = ~opcode[2];
end



//attempt fix
//always @ (button) begin
//	if(button[0] == 1) begin
//		opcode[0] = ~opcode[0];
//	end
//	if(button[1] == 1) begin
//		opcode[1] = ~opcode[1];
//	end
//	if(button[2] == 1) begin
//		opcode[2] = ~opcode[2];
//	end
//end



//always @ (data_in or rst or opcode) begin
always @ (posedge clk) begin
	if (rst) begin
		data_out = 8'b0;
		//opcode = 3'b0;
	end 
	else begin

		if (opcode[2:0] == 3'b000) begin		   //ADD
			data_out = data_in[7:4] + data_in[3:0];
		end
		else if (opcode[2:0] == 3'b001) begin		//SUB
			data_out = data_in[7:4] - data_in[3:0];
		end
		else if (opcode[2:0] == 3'b010) begin		//AND
			data_out = data_in[7:4] & data_in[3:0];
		end
		else if (opcode[2:0] == 3'b011) begin		//OR
			data_out = data_in[7:4] | data_in[3:0];
		end
		else if (opcode[2:0] == 3'b100) begin		//MUL
			data_out = data_in[7:4] * data_in[3:0];
		end
		else if (opcode[2:0] == 3'b101) begin		//LT
			if (data_in[7:4] < data_in[3:0]) begin
				data_out = 8'b1;
			end
			else begin
				data_out = 8'b0;
			end
		end
		else if (opcode[2:0] == 3'b110) begin		//GT
			if (data_in[7:4] > data_in[3:0]) begin
				data_out = 8'b1;
			end
			else begin
				data_out = 8'b0;
			end
		end
		else if (opcode[2:0] == 3'b111) begin		//XOR
			data_out = data_in[7:4] ^ data_in[3:0];
		end
	end
end



endmodule

