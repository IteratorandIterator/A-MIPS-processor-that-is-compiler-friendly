`timescale 1ns / 1ps

module MultCore(
	input logic clk,
	input logic [31:0]	A, 
	input logic [31:0]	B, 
	input logic start, 
	input logic sign,

	output logic [31:0]	HI,
	output logic [31:0]	LO,
	output logic DataOK,
	output logic Busy
    );
//Unsigned Mult Only
	logic [31:0] PosiA = (A[31]&sign)?-A:A, PosiB = (B[31]&sign)?-B:B;
	logic [63:0]	A_Ext = {32'b0,PosiA}, B_Ext = {32'b0,PosiB};
	logic [63:0]	Wire_0[31:0];
	logic [63:0]	Buf_0[15:0], Buf_1[7:0], Buf_2[3:0], Buf_3[1:0];
	
	logic [63:0]	C = (^Nega_Buf	?	-Ans_Wire:Ans_Wire);
	logic [4: 0]	T;
	logic [1: 0] 	Nega;
	assign	Nega[1] = (A[31]&sign), Nega[0]	= (B[31]&sign);
	

	logic [1:0] Nega_Buf;
	assign Busy = T[1];
	assign {HI,LO}=C;
	assign	DataOK = (T[1:0]==2'b01);
	logic	[63:0]	Ans_Wire = Buf_3[0] + Buf_3[1];

	always_ff @(posedge clk) begin
		T <= start	?	5'b01111:
						(T>>1);
		Nega_Buf <= start ? Nega:Nega_Buf;
	end
	
	
	generate
		genvar i;
		for(i=0;i<32;i=i+1)
		begin:OffsetData
			assign Wire_0[i] = A_Ext[i]==0	?	0:(B_Ext<<i);
		end
		for(i=0;i<16;i=i+1)
		begin:Layer_0
			always_ff @(posedge clk)
				Buf_0[i] <= Wire_0[i] + Wire_0[31-i];
		end
		for(i=0;i<8;i=i+1)
		begin:Layer_1
			always_ff @(posedge clk)
				Buf_1[i] <= Buf_0[i] + Buf_0[15-i];
		end
		for(i=0;i<4;i=i+1)
		begin:Layer_2
			always_ff @(posedge clk)
				Buf_2[i] <= Buf_1[i] + Buf_1[7-i];
		end
		for(i=0;i<2;i=i+1)
		begin:Layer_3
			always_ff @(posedge clk)
				Buf_3[i] <= Buf_2[i] + Buf_2[3-i];
		end
	endgenerate
	
	

endmodule
