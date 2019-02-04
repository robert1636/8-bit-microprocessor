`include "microprocessor.v"

module tb(
	output [7:0] data_out,
	reg rst,
	reg [7:0] data_in,
	reg [2:0] pb,
	output [2:0] opcode,
	output [2:0] button,
	reg clk
);

//wire [2:0] mm;
////wire a;
//assign button_tb = mm; 
// Instantion of the design
microprocessor dut(
		.rst(rst),
		.data_in(data_in),
		.data_out(data_out),
		.pb(pb),
		.opcode(opcode),
		.button(button),
		.clk(clk)
);

//debounce testt(.pb_out(a));

initial begin
  clk = 0;
  forever #10 clk = ~clk;
 end
 
 
initial begin
	rst = 1;
	data_in = 8'b000_10_00;		
	pb = 3'b000;
	#12 rst = 0;
	//$monitor("",$time,opcode[0],opcode[1],opcode[2] );
	#10 	//button = 3'b000;
	data_in = 8'b1010_0010;			   //ADD: 10+2 = 12
	
  pb[0] = 0;
  #10;
  pb[0]=1;
  #20;
  pb[0] = 0;
  #10;
  pb[0]=1;
  #30; 
  pb[0] = 0;
  #10;
  pb[0]=1;
  #40;
  pb[0] = 0;
  #10;
  pb[0]=1;
  #30; 
  pb[0] = 0;
  #10;
  pb[0]=1; 
  #400; 
  pb[0] = 0;
  #10;
  pb[0]=1;
  #20;
  pb[0] = 0;
  #10;
  pb[0]=1;
  #30; 
  pb[0] = 0;
  #10;
  pb[0]=1;
  #40;
  pb[0] = 0; 
  data_in = 8'b1011_0010;				
			
  pb[1] = 0;
  #10;
  pb[1]=1;
  #20;
  pb[1] = 0;
  #10;
  pb[1]=1;
  #30; 
  pb[1] = 0;
  #10;
  pb[1]=1;
  #40;
  pb[1] = 0;
  #10;
  pb[1]=1;
  #30; 
  pb[1] = 0;
  #10;
  pb[1]=1; 
  #400; 
  pb[1] = 0;
  #10;
  pb[1]=1;
  #20;
  pb[1] = 0;
  #10;
  pb[1]=1;
  #30; 
  pb[1] = 0;
  #10;
  pb[1]=1;
  #40;
  pb[1] = 0; 
  data_in = 8'b1110_0010;				
			
  pb[1] = 0;
  #10;
  pb[2]=1;
  #20;
  pb[2] = 0;
  #10;
  pb[2]=1;
  #30; 
  pb[2] = 0;
  #10;
  pb[2]=1;
  #40;
  pb[2] = 0;
  #10;
  pb[2]=1;
  #30; 
  pb[2] = 0;
  #10;
  pb[2]=1; 
  #400; 
  pb[2] = 0;
  #10;
  pb[2]=1;
  #20;
  pb[2] = 0;
  #10;
  pb[2]=1;
  #30; 
  pb[2] = 0;
  #10;
  pb[2]=1;
  #40;
  pb[2] = 0; 
  data_in = 8'b1010_1110;				
			
//	#10 	//button = 3'b010;
//	#10  pb[1] = 1'b1;
//	#10   pb[1] = 1'b0;
//	#10   pb[0] = 1'b1;
//	#10   pb[0] = 1'b0;
//			data_in = 8'b1010_0010;			   //AND: 10 & 2 = 2
//		
//	#10 	//button = 3'b011;
//	#10   pb[0] = 1'b1;
//	#10   pb[0] = 1'b0;
//			data_in = 8'b1010_0010;				//OR:  10 | 2 = 10
//			
//	#10 	//button = 3'b100;
//	#10   pb[0] = 1'b1;
//	#10   pb[0] = 1'b0;
//	#10   pb[1] = 1'b1;
//	#10   pb[1] = 1'b0;
//	#10   pb[2] = 1'b1;
//	#10   pb[2] = 1'b0;
//			data_in = 8'b1010_0010;				//MUL: 10 * 2 = 20
//			
//	#10 	//button = 3'b101;
//	#10   pb[1] = 1'b1;
//	#10   pb[1] = 1'b0;
//			data_in = 8'b1010_0010;				//SLT: 10 < 2 = 0
//			
//	#10 	//button = 3'b110;
//	#10   pb[0] = 1'b1;
//	#10   pb[0] = 1'b0;
//	#10   pb[1] = 1'b1;
//	#10   pb[1] = 1'b0;
//			data_in = 8'b1010_0010;				//SGT: 10 > 2 = 1
//			
//	#10 	//button = 3'b111;
//	#10   pb[0] = 1'b1;
//	#10   pb[0] = 1'b0;
//			data_in = 8'b1010_0010;				//XOR: 10 ^ 2 = 8


end
endmodule

