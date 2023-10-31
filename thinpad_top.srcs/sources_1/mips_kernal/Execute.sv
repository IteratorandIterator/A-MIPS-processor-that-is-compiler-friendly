`timescale 1ns / 1ps
`include "Common.sv"

module Execute(
    input logic clk,
    input logic rst,
	input logic [31:0]	EXE_IN1,
	input logic [31:0]	EXE_IN2,
    input logic [4:0]   EXE_IN3,
    input logic [4:0]   EXE_IN4,
    input logic [31:0]  EXE_IN5,
    input logic [31:0]  EXE_IN6,
    input logic [4:0]   EXE_IN7,
    input logic [15:0]  EXE_IN8,
    input logic [`InstrBusWidth]  EXE_IN9,
    input logic [3:0]   EXE_IN10,
    input logic 		EXE_IN11,
    input logic [4:0]   EXE_IN12,
    
    input logic 		EXE_IN13,
    input logic [4:0]   EXE_IN14,
    input logic [31:0]  EXE_IN15,

	output logic	[31:0]	EXE_OUT1,
	output logic 	[31:0]	EXE_OUT2,
    output logic   [31:0]   EXE_OUT3,
    output logic [4:0]    EXE_OUT4,

    output logic	[3:0]   EXE_OUT5,
    output logic			EXE_OUT6,
    output logic	[4:0]	EXE_OUT7,
    output logic	[31:0]  EXE_OUT8,

    
    output logic	[3:0]   EXE_OUT9,
	output logic	EXE_OUT10,
    output logic	EXE_OUT11,
	output logic	[4:0]   EXE_OUT12,

	output logic EXE_OUT13,
	input logic [31:0] EXE_IN16,

	output logic EXE_OUT14,
	output logic EXE_OUT15,
	output logic EXE_OUT16,
	output logic [3:0]  EXE_OUT17,
	output logic [31:0] EXE_OUT18,

	output logic EXE_OUT19,
	output logic EXE_OUT20,
	output logic EXE_OUT21,
	output logic [3:0]  EXE_OUT22,
	output logic [31:0] EXE_OUT23,

	output logic EXE_OUT24,
	output logic EXE_OUT25,
	output logic EXE_OUT26,

	output logic EXE_OUT27,
	output logic EXE_OUT28,
	output logic [4:0] EXE_OUT29,
	output logic EXE_OUT30
    );
	logic	`InstrBusWireSet;
	assign	{`InstrBusWireSet}	=	EXE_IN9;

	always_ff @(posedge clk) begin
		EXE_OUT30 <= slti;
	end
    /////////////////////转发////////////////
    logic    [31:0]  MF_Rs = (EXE_IN3!=0 && EXE_IN3==EXE_OUT7 && EXE_OUT5==0 && EXE_OUT6)		?   EXE_OUT8:
                            (EXE_IN3!=0 && EXE_IN14==EXE_IN3 && EXE_IN13 )					?   EXE_IN15:
                                                                                                    EXE_IN5;
    logic    [31:0]  MF_Rt = (EXE_IN4!=0 && EXE_IN4==EXE_OUT7 && EXE_OUT5==0 && EXE_OUT6)		?	EXE_OUT8:
                            (EXE_IN4!=0 && EXE_IN14==EXE_IN4 && EXE_IN13)					?   EXE_IN15://M级结束（实际上是W级了），那么T必定�???
                                                                                                    EXE_IN6;

    logic    [31:0]  C_Inter;
    	/////////////////////For Mem Addr/////
	logic [31:0] ext_imm32 = {{16{EXE_IN8[15]}},EXE_IN8};
	logic [31:0] MemAddr = C_Inter;//ext_imm32+MF_Rs;
    logic    [4:0]   ExtType_Inter;
	logic	[3:0]	MemBitEnable_Inter;
    logic			MemWriteEnable_Inter;
    logic    		MemReadEnable_Inter;
	logic MemAddr_in_base_inter = (32'h8000_0000<=MemAddr && MemAddr <=32'h803F_FFFF);
	logic MemAddr_in_ext_inter  = (32'h8040_0000<=MemAddr && MemAddr <=32'h807F_FFFF);

	logic Reading_base_inter = MemAddr_in_base_inter&MemReadEnable_Inter;
	logic Writing_base_inter = MemAddr_in_base_inter&MemWriteEnable_Inter;
	logic Using_base_inter = (MemAddr_in_base_inter)&(MemReadEnable_Inter|MemWriteEnable_Inter);
	logic [3:0] Base_bit_enable_inter = Using_base_inter ? MemBitEnable_Inter:4'b1111;
	logic [31:0] Base_addr_inter = Using_base_inter?MemAddr:EXE_IN16;

	logic Reading_ext_inter = MemAddr_in_ext_inter&MemReadEnable_Inter;
	logic Writing_ext_inter = MemAddr_in_ext_inter&MemWriteEnable_Inter;
	logic Using_ext_inter = (MemAddr_in_ext_inter)&(MemReadEnable_Inter|MemWriteEnable_Inter);
	logic [3:0] Ext_bit_enable_inter = Using_ext_inter ? MemBitEnable_Inter:4'b1111;
	logic [31:0] Ext_addr_inter = MemAddr;

	logic Reading_UART_Data_inter = MemAddr==32'hBFD003F8&MemReadEnable_Inter;
	logic Writing_UART_Data_inter = MemAddr==32'hBFD003F8&MemWriteEnable_Inter;
	logic Reading_UART_STATUS_inter = MemAddr==32'hBFD003FC&MemReadEnable_Inter;

	//////////////////////////////////////////////////////////////////////////////////
	assign  EXE_OUT28 = EXE_OUT16;
	logic [31:0] XALU_HI,
				XALU_LO;
	logic		XALU_Busy_Inter;
	logic	[1:0]	Offset = MemAddr[1:0];
	ALU ALU(
		.Leftop(MF_Rs),
		.Rightop(MF_Rt),
		.shamt(EXE_IN7),
		.Imm16(EXE_IN8),
		.InstrBus(EXE_IN9),
		.Result(C_Inter),
		.PC(EXE_IN1),
	 	.Offset(Offset),
	 	.ExtType(ExtType_Inter),
	 	.MemBitEnable(MemBitEnable_Inter),
	 	.MemReadEnable(MemReadEnable_Inter),
	 	.MemWriteEnable(MemWriteEnable_Inter));
    ALUwithHILO ALUwithHILO(
		.clk(clk),
		.rst(rst),
		.InstrBus(EXE_IN9),
		.Leftop(MF_Rs),
		.Rightop(MF_Rt),
		.Result2HI(XALU_HI),
		.Result2LO(XALU_LO),
		.Isbusy(XALU_Busy_Inter));
    logic    [3:0] E_T_Inter = (EXE_IN10 > 0)?EXE_IN10-1:0;
	logic	[31:0]	Data_Inter = 	mfhi	?	XALU_HI:
									mflo	?	XALU_LO:
												C_Inter;
    always_ff @(posedge clk) begin
        if(rst) begin
			EXE_OUT1 <= 0;
			EXE_OUT2<=0;
			EXE_OUT3 <= 0;
			EXE_OUT4 <= 0;
			EXE_OUT5 <= 0;
			EXE_OUT6 <= 0;
			EXE_OUT7 <= 0;
			EXE_OUT8 <= 0;
			EXE_OUT12 <= 0;
			EXE_OUT10 <= 0;
			EXE_OUT11 <= 0;
			EXE_OUT9 <= 0;

			//初始化可能有问题
			EXE_OUT14<=0;
			EXE_OUT15<=1;
			EXE_OUT16<=0;
			EXE_OUT17<=0;
			EXE_OUT18<=0;

			EXE_OUT19<=1;
			EXE_OUT20<=1;
			EXE_OUT21<=0;
			EXE_OUT22<=0;
			EXE_OUT23<=0;

			EXE_OUT24<=0;
			EXE_OUT25<=0;
			EXE_OUT26<=0;
			EXE_OUT27<=0;
		end
		else begin
			EXE_OUT1 <= EXE_IN1;
			EXE_OUT2<=EXE_IN2;
			EXE_OUT3 <= MF_Rt;//<<{Offset,3'b0};
			EXE_OUT4 <= EXE_IN4;
			EXE_OUT5 <= EXE_IN10 ==4'b0 ? 4'b0 : EXE_IN10-1;
			EXE_OUT6 <= EXE_IN11;
			EXE_OUT7 <= EXE_IN12;
			EXE_OUT8 <= Data_Inter;
			EXE_OUT12 <= ExtType_Inter;
			EXE_OUT10 <= MemReadEnable_Inter;
			EXE_OUT11 <= MemWriteEnable_Inter;
			EXE_OUT9 <= MemBitEnable_Inter;


			EXE_OUT19<=~Reading_ext_inter;
			EXE_OUT20<=~Writing_ext_inter;
			EXE_OUT21<=Using_ext_inter;
			EXE_OUT22<=~Ext_bit_enable_inter;
			EXE_OUT23<=Ext_addr_inter;


			EXE_OUT14<=~Reading_base_inter;
			EXE_OUT15<=~Writing_base_inter;
			EXE_OUT16<=Using_base_inter;
			EXE_OUT17<=~Base_bit_enable_inter;
			EXE_OUT18<=Base_addr_inter;

			EXE_OUT26<=Reading_UART_STATUS_inter;

			EXE_OUT24<=Reading_UART_Data_inter;
			EXE_OUT25<=Writing_UART_Data_inter;
			EXE_OUT27<=EXE_OUT6&EXE_OUT7==EXE_IN4;
		end
		
    end
		assign EXE_OUT13 = XALU_Busy_Inter;

endmodule
