`timescale 1ns / 1ps
`include "Common.sv"

module ALUwithHILO(
    input logic clk,
    input logic rst,
    input logic [`InstrBusWidth] InstrBus,
	
    input logic [31:0] Leftop,
    input logic [31:0] Rightop,
    output logic [31:0] Result2HI,
    output logic [31:0] Result2LO,

    output logic Isbusy
    );


	assign	{`InstrBusWireSet}	=	InstrBus;
	logic MulSel;
	logic [1:0] WriteEnable = {mthi,mtlo};
	
	
	assign	Isbusy = MulSel ? Mul_Busy:Div_Busy; 	
	
	initial begin
		MulSel=0;
	end

	logic XALU_Start = (mult|multu|div|divu);
	
	logic Div_Busy,Div_OK;
	logic [31:0] Div_HI,Div_LO;
	logic XALU_sign = (mult|div);
	

	DivCore DivCore(
		.clk(clk),
		.sign(XALU_sign),
		.A(Leftop),
		.B(Rightop),
		.start(XALU_Start),

		.DataOK(Div_OK),
		.HI(Div_HI),
		.LO(Div_LO),
		.Busy(Div_Busy)
	);
	
	logic [31:0] Mul_HI,Mul_LO;
	logic Mul_Busy,Mult_OK;
	MultCore MultCore(
		.clk(clk),
		.A(Leftop),
		.B(Rightop),
		.HI(Mul_HI),
		.LO(Mul_LO),
		.start(XALU_Start),
		.sign(XALU_sign),
		.DataOK(Mult_OK),
		.Busy(Mul_Busy)
	);

	always_ff @(posedge clk) begin
		
		if(!rst && XALU_Start) begin
			if(mult) begin
				MulSel <= 1;	
			end
			if(multu) begin
				MulSel <= 1;
			end
			if(div) begin
				MulSel <= 0;
			end
			if(divu) begin
				MulSel <= 0;
			end
		end
		Result2HI <= mthi ?	Leftop: MulSel && Mult_OK ?	Mul_HI: Div_OK ? Div_HI: Result2HI;
		Result2LO <= mtlo ?	Leftop: MulSel && Mult_OK ?	Mul_LO: Div_OK ? Div_LO: Result2LO;
	end
	
	
endmodule
