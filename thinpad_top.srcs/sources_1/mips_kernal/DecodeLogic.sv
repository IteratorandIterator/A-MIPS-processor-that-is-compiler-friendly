`timescale 1ns / 1ps
`include "Common.sv"

module DecodeLogic(
	input  logic [31:0]	CurrentInstr, //
	output logic [4:0] Shamt,
    output logic [4:0] Rs,
	output logic [4:0] Rt,
	output logic [4:0] Rd,
	output logic [15:0] Imm16,
	output logic [25:0] Imm26,
	output 	logic WE,	//
	output	logic [4:0]	RegAddr,
	output	logic [`InstrBusWidth]	InstrBus
    );
	assign Rs	=	CurrentInstr[`RsBITS];
	assign Rt	=	CurrentInstr[`RtBITS];
	assign Rd	=	CurrentInstr[`RdBITS];
	assign Shamt	=	CurrentInstr[`ShamtBITS];
	assign Imm16	=	CurrentInstr[`IMM16BITS];
	assign Imm26	=	CurrentInstr[`IMM26BITS];
	////////////////////////////
	logic [5:0] OpCode = CurrentInstr[31:26],Funct = CurrentInstr[5:0];

	assign  {`InstrBusWireSet} = {
		(OpCode==6'h20),(OpCode==6'h24),(OpCode==6'h21),(OpCode==6'h25),
		(OpCode==6'h23),(OpCode==6'h28),(OpCode==6'h29),(OpCode==6'h2b),

		(OpCode==6'h8),(OpCode==6'h9),(OpCode==6'h0 && Funct==6'h20),
		(OpCode==6'h0 && Funct==6'h21),(OpCode==6'h0 && Funct==6'h22),
		(OpCode==6'h0 && Funct==6'h23),(OpCode==6'hf),

		(OpCode==6'hd),(OpCode==6'h0 && Funct==6'h24),(OpCode==6'h0 && Funct==6'h25),
		(OpCode==6'h0 && Funct==6'h26),(OpCode==6'h0 && Funct==6'h27),
		(OpCode==6'hc),(OpCode==6'he),

		(OpCode==6'h4),(OpCode==6'h5),(OpCode==6'h6),(OpCode==6'h7),
		(CurrentInstr[31:26]==6'h1 && CurrentInstr[20:16]==6'h0),
		(CurrentInstr[31:26]==6'h1 && CurrentInstr[20:16]==6'h1),
		(OpCode==6'h2),(OpCode==6'h3),(OpCode==6'h0 && Funct==6'h8),
		(OpCode==6'h0 && Funct==6'h9),(CurrentInstr==32'b0),

		(OpCode==6'h0 && Funct==6'h18),(OpCode==6'h0 && Funct==6'h19),
		(OpCode==6'h0 && Funct==6'h1a),(OpCode==6'h0 && Funct==6'h1b),
		(OpCode==6'h0 && Funct==6'h10),(OpCode==6'h0 && Funct==6'h11),
		(OpCode==6'h0 && Funct==6'h12),(OpCode==6'h0 && Funct==6'h13),

		(OpCode==6'h0 && Funct==6'h0),(OpCode==6'h0 && Funct==6'h2),
		(OpCode==6'h0 && Funct==6'h3),(OpCode==6'h0 && Funct==6'h4),
		(OpCode==6'h0 && Funct==6'h6),(OpCode==6'h0 && Funct==6'h7),

		(OpCode==6'h0 && Funct==6'h2a),(OpCode==6'ha),
		(OpCode==6'h0 && Funct==6'h2b),(OpCode==6'hb),

		(OpCode==6'b010000 && CurrentInstr[25:21]==5'b00000),
		(OpCode==6'b010000 && CurrentInstr[25:21]==5'b00100),
		(CurrentInstr==32'h42000018),
		(OpCode==6'b011100 && CurrentInstr[10:0]==11'b00000_000010)
	};

	assign  WE = ~nop && (`DecodeForWE);
	assign	RegAddr = (`DecodeForReg);
	assign	InstrBus=	{`InstrBusWireSet};
endmodule
