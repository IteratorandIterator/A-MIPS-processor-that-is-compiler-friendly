`timescale 1ns / 1ps
`include "Common.sv"

module ALU(
	input logic [31:0]	Leftop,
	input logic [31:0]	Rightop,
	input logic [4:0]	shamt,
	input logic [15:0]	Imm16,
	input logic [31:0]	PC,
	input logic [`InstrBusWidth]	InstrBus,
	output logic [31:0]	Result,
    input logic [1:0]   Offset,
	output logic [4:0]   ExtType,
    output logic [3:0]   MemBitEnable,
    output logic MemReadEnable,
    output logic MemWriteEnable
    );
	assign {`InstrBusWireSet} = InstrBus;
	logic zeroExtend = ori|Andi|Xori;
	logic [31:0] Imm32 = zeroExtend	? {{16'b0},Imm16}: lui ? {Imm16,{16'b0}}:{{16{Imm16[15]}},Imm16};
	logic AS_Family	= ((addiu|addu)|(((add|addi)|(lw|sw|lb))|((lbu|lh|lhu)|(sb|sh))))|(subu|sub);
	logic [31:0] AS_A,AS_B;
	logic	isReg	=	((add|addu)|(sub|subu));
	assign	AS_A	=	Leftop;
	assign	AS_B	=	isReg	?	Rightop	:	Imm32;
	logic	[32:0]	signedAddTmp	=	{AS_A[31],AS_A}+{AS_B[31],AS_B},
					signedSubTmp	=	{AS_A[31],AS_A}-{AS_B[31],AS_B};
	logic	[31:0]	signedAddAns	=	signedAddTmp[31:0],
					signedSubAns	=	signedSubTmp[31:0],
					unsignAddAns	=	AS_A+AS_B,
					unsignSubAns	=	AS_A-AS_B;
	logic	addOverFlow	=	signedAddTmp[32]!=signedAddTmp[31],
			subOverFlow	=	signedSubTmp[32]!=signedSubTmp[31];
	logic	[31:0]	AS_Ans	=	(subu)			?	unsignSubAns:
								(sub)			?	signedSubAns:
								(addiu|addu)	?	unsignAddAns:
													signedAddAns;
	//////////////////BitCal Family/////////////////////////////////////
	logic	BC_Family	=	((ori|Or)|	
							(And|Andi))|
							((Xor|Xori)|	
							(Nor|lui));
	logic	[31:0]	BC_A	=	Leftop,
					BC_B	=	(ori|Andi|Xori)	?	Imm32	:	Rightop;
	logic	[31:0]	BC_Ans	=	(Xor|Xori)	?	BC_A^BC_B:
								(ori|Or)	?	BC_A|BC_B:
								(And|Andi)	?	BC_A&BC_B:
								(lui)		?	Imm32:
												~(BC_A|BC_B);//Nor
	//////////////////Shamt	Family/////////////////////////////////////
	logic	sllType   =   sll|sllv,
				srlType	=	srl|srlv,
				sraType	=	sra|srav;
	logic	ST_Family	=	sllType|srlType|sraType;
	logic	[31:0]	ST_A	=	(sll|srl|sra)	?	shamt	:	Leftop,
					ST_B	=	Rightop;
	logic 	[31:0]	ST_Ans	=	sllType	?	ST_B<<ST_A[4:0]:
								srlType	?	ST_B>>ST_A[4:0]:
								$signed($signed(ST_B)>>>ST_A[4:0]);
	/////////////////CMP Family////////////////////////////////////////
	logic	sltType		=	slt|slti,
			sltuType	=	sltu|sltiu;
	logic	CMP_Family	=	sltType|sltuType;

	logic	[31:0]	CMP_A 	=	Leftop,
					CMP_B 	=	(slti|sltiu)	?	Imm32	:	Rightop;
	logic	[31:0]	CMP_Ans	=	sltType	?	($signed(CMP_A)<$signed(CMP_B)):
											($unsigned(CMP_A)<$unsigned(CMP_B));
	/////////////////JL Family/////////////////////////////////////////
	logic	JL_Family 	=	jal|jalr;
	logic	[31:0]	JL_Ans	=	PC+8;
	/////////////////MUL///////////////////////////////////////////////
	logic 	[31:0] MUL_Ans;
	logic	MUL_Family = mul;
	mult_gen_0 Multer (
		.A(Leftop),  // input wire [31 : 0] Leftop
		.B(Rightop),  // input wire [31 : 0] Rightop
		.P(MUL_Ans)  // output wire [63 : 0] P
		);
	/////////////////OUT PUT///////////////////////////////////////////
	assign	Result 	=	AS_Family	?	AS_Ans:
					BC_Family	?	BC_Ans:
					ST_Family	?	ST_Ans:
					CMP_Family	?	CMP_Ans:
					JL_Family	?	JL_Ans:
					MUL_Family	?	MUL_Ans:
									32'h22222222;//DEBUG

     assign	ExtType = {lb,lbu,lh,lhu,lw};
     assign  MemWriteEnable = sb|sh|sw;
     assign  MemReadEnable = lb|lbu|lh|lhu|lw;

     assign  MemBitEnable  = sw|lw       ?   4'b1111:
                             sh|lh|lhu   ?   4'b0011<<Offset:
                             sb|lb|lbu   ?   4'b0001<<Offset:
                                             4'b0000;
endmodule
