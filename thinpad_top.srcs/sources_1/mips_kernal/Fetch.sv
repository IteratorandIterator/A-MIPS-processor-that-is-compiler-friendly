`timescale 1ns / 1ps

`define TextAddr 32'h8000_0000
module Fetch(
    input logic clk,
    input logic rst,
    input   	FETCH_IN1,
    input logic [31:0]  FETCH_IN2,
    output logic [31:0]	FETCH_OUT1,	//流水线寄存器
	output logic [31:0]	FETCH_OUT2, //直接输出
    output logic [31:0] 	FETCH_OUT3, //直接输出
    input  logic [31:0] FETCH_IN3,
	input  logic FETCH_IN4,//与M级的访问出现冲突
	output logic [31:0] FETCH_OUT4	//直接输出
    );

    assign I_stall_Pass = FETCH_IN4;

    logic [31:0] PC_Inter;
	logic [31:0] Instr_r;
    logic[31:0] Instr_Inter;

	assign FETCH_OUT2 = PC_Inter;
    assign Instr_Inter = FETCH_IN3;
	assign I_sram_addr = PC_Inter;
	assign FETCH_OUT3 = Instr_r;
	assign	FETCH_OUT4 = rst ? `TextAddr:(FETCH_IN1||FETCH_IN4)?PC_Inter:FETCH_IN2;
    always_ff  @(posedge clk)   begin
		if(rst) begin
			PC_Inter<=`TextAddr;
			FETCH_OUT1 <= 0;
			Instr_r<= 0;
		end
		else if(FETCH_IN1 || FETCH_IN4) begin
			PC_Inter<=PC_Inter;
		end
		else begin
			FETCH_OUT1 <= PC_Inter;
			Instr_r<= Instr_Inter;
			PC_Inter<=FETCH_IN2;
		end
    end
endmodule
