`timescale 1ns / 1ps

module DivCore(
    input logic clk,
	input logic sign,
    input logic [31:0] A,
    input logic [31:0] B,
	input logic start,

	output logic DataOK,
	output logic [31:0]	HI,
	output logic [31:0]	LO,
	output logic Busy
    );
	logic [31:0] PosiA = (A[31]&sign)?-A:A, PosiB = (B[31]&sign)?-B:B;

	logic [31:0] T;
	assign Busy = T[1];
	logic Busy_Buf;
	logic [1:0] Nega;
	assign	Nega[1] = (A[31]&sign), Nega[0]	= (B[31]&sign);
	logic [1:0] Nega_Buf;
	logic Complete = ~T[0];
	
	logic [66:0] tmpA,tmpB1,tmpB2,tmpB3;
	logic [66:0] sub1 = (tmpA<<2) - tmpB1,sub2 = (tmpA<<2) - tmpB2,sub3 = (tmpA<<2) - tmpB3;
	logic [31:0] debug = tmpA[31:0];
	always_ff @(posedge clk) begin
		if(start) begin
			T <= 32'hffffffff;
			Nega_Buf <= Nega;
			tmpA <= {32'b0,PosiA};
			tmpB1 <= {PosiB,32'b0};
			tmpB2 <= {PosiB,32'b0}+{PosiB,32'b0};
			tmpB3 <= {PosiB,33'b0}+{PosiB,32'b0};
		end
		else if(T[15]&&(tmpA[47:16]<tmpB1[63:32])) begin
			T <= (T>>16);
			tmpA <= (tmpA<<16);
		end
		else if(T[7]&&(tmpA[55:24]<tmpB1[63:32])) begin
			T <= (T>>8);
			tmpA <= (tmpA<<8);
		end
		else if(T[3]&&(tmpA[59:28]<tmpB1[63:32])) begin
			T <= (T>>4);
			tmpA <= (tmpA<<4);
		end
		else if(T[0]) begin
			T <= (T>>2);
			tmpA <= (!sub3[66]) ? sub3 + 3:
					(!sub2[66]) ? sub2 + 2:
					(!sub1[66]) ? sub1 + 1:
										   tmpA<<2;
		end
		Busy_Buf <= Busy;
	end

	assign	DataOK = (Busy_Buf==1'b1 && Busy==1'b0);
	assign	HI = Nega_Buf[1]	?	(-tmpA[63:32]):tmpA[63:32],
			LO = (Nega_Buf[1]^Nega_Buf[0])	?	(-tmpA[31:0]):tmpA[31:0];

endmodule

