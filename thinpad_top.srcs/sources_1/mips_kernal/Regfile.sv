`timescale 1ns / 1ps
`include "Common.sv"

module Regfile(
	input logic clk,
	input logic rst,
	input logic [4:0]	raddr1,
	input logic [4:0]	raddr2,
	input logic [4:0]	waddr,
	input logic 	we,
	input logic [31:0]	wdata,
	output logic [31:0]	rdata1,
	output logic [31:0]	rdata2
    );
	logic	[31:0]	Regs	[31:0];
	assign	rdata1 = (raddr1 == 0) ? 0: (waddr == raddr1 && we) ? wdata: Regs[raddr1];
	assign	rdata2 = (raddr2 == 0) ? 0: (waddr == raddr2 && we) ? wdata: Regs[raddr2];

	always_ff @(posedge clk) begin
		if(rst)begin
			for(int i=0;i<32;i=i+1)
				Regs[i]=0;
		end
		else if(we) begin
			if(waddr!=0) begin
				Regs[waddr]=wdata;
			end
		
		end
	end
	
endmodule