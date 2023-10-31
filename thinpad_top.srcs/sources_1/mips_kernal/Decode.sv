`timescale 1ns / 1ps
`include "Common.sv"

module Decode(
    input   logic clk,
    input   logic rst,
    input   logic W_WriteRegEnable,
    input   logic [4:0]   W_RegWriteId,
    input   logic [31:0]  W_RegWriteData,

	input	logic [31:0]	I_PC_Pass,
    input   logic [31:0]  I_PC, /*删除*/
    input   logic [31:0]  I_MipsInstr, /*保留*/
	input	logic [31:0]	W_PC,
    output  logic [31:0]  D_NewPC_Pass,///pass through  直接输出
	output	logic [31:0]	D_PC,	// 流水线寄存器
	output	logic [31:0]	D_Instr, //流水线寄存器
	output	logic [4:0]	D_RsID,	//流水线寄存器
	output	logic [4:0]	D_RtID, //流水线寄存器
	output  logic [31:0]  D_RsData,//流水线寄存器
    output  logic [31:0]  D_RtData,//流水线寄存器
    output  logic [4:0]   D_Shamt,//流水线寄存器
    output  logic [15:0]  D_Imm16,//流水线寄存器
    output	logic [`InstrBusWidth]	D_InstrBus,//流水线寄存器
    
    input   logic [3:0]   E_T,
    input   logic         E_WriteRegEnable,
    input   logic [4:0]   E_RegId,
    input   logic [31:0]  E_Data,
	input			E_XALU_Busy,
	
    output  logic [3:0]   D_T,//寄存器，但是不管，还是直接输出
    output  logic         D_WriteRegEnable,//寄存器，但是不管，还是直接输出
    output  logic [4:0]   D_RegId,//寄存器，但是不管，还是直接输出

    output 			D_stall_Pass,

	input			I_sram_busy
    );
	
    logic [25:0]     Imm26_Inter;
    logic [15:0]     Imm16_Inter;
    logic [4:0]		Rs_Inter,Rt_Inter,Rd_Inter,Shamt_Inter;
    logic [`InstrBusWidth]		InstrBus_Inter;
	logic			WriteRegEnable_Inter;
	logic [4:0] 		WriteRegId_Inter;
	
    DecodeLogic  DecodeLogic(.CurrentInstr(I_MipsInstr),.Rs(Rs_Inter),.Rt(Rt_Inter),.Rd(Rd_Inter),.Shamt(Shamt_Inter),.Imm16(Imm16_Inter),.Imm26(Imm26_Inter),
							.WE(WriteRegEnable_Inter),.RegAddr(WriteRegId_Inter),.InstrBus(InstrBus_Inter));

    logic [31:0] RsData_Inter,RtData_Inter;
    Regfile Regfile(.clk(clk),.rst(rst),/*.PC(W_PC),*/.raddr1(Rs_Inter),.raddr2(Rt_Inter),
            .waddr(W_RegWriteId),.we(W_WriteRegEnable),.wdata(W_RegWriteData),
            .rdata1(RsData_Inter),.rdata2(RtData_Inter));

	logic    [31:0]  MF_Rs = (Rs_Inter!=0 && Rs_Inter==E_RegId && E_T==0 && E_WriteRegEnable)    ?   E_Data:
                                                                                                    RsData_Inter;
    logic    [31:0]  MF_Rt = (Rt_Inter!=0 && Rt_Inter==E_RegId && E_T==0 && E_WriteRegEnable)    ?   E_Data:
                                                                                                    RtData_Inter;
    //////////////////////
    JumpLogic JumpLogic(.rst(rst),.CurrentInstr(I_MipsInstr),.RsData(MF_Rs),.RtData(MF_Rt),.CurrentPC(I_PC_Pass),.TargetPC(D_NewPC_Pass));

	assign {`InstrBusWireSet} = InstrBus_Inter;
	logic MultCalFamily_Inter = (mult|multu|div|divu);
	logic	D_MultCalFamily;
    logic    [3:0]   T_Inter;
    StallLogic StallLogic(.InstrBus(InstrBus_Inter),.Rs(Rs_Inter),.Rt(Rt_Inter),.D_T(D_T),.WE_D(D_WriteRegEnable),.D_RegId(D_RegId),.E_T(E_T),.WE_E(E_WriteRegEnable),.E_RegId(E_RegId),
                        .stall(D_stall_Pass),.OUTT(T_Inter),.ALUwithHILO(E_XALU_Busy),.D_MultCalFamily(D_MultCalFamily));

    always_ff @(posedge clk)  begin
        if(rst|D_stall_Pass|I_sram_busy) begin
			D_PC <= 0;
			D_Instr<=0;
			D_RsID <= 0;
			D_RtID <= 0;
			D_RsData <= 0;
			D_RtData <= 0;
			D_Shamt <= 0;
			D_Imm16 <= 0;
			D_InstrBus <= 0;
			D_T <= 0;
			D_WriteRegEnable <= 0;
			D_RegId <= 0;
			D_MultCalFamily <= 0;
		end
		else begin
			D_PC	<= I_PC;
			D_Instr<=I_MipsInstr;
			D_RsID 	<= Rs_Inter;
			D_RtID 	<= Rt_Inter;
			D_RsData <= RsData_Inter;
			D_RtData <= RtData_Inter;
			D_Shamt	<= Shamt_Inter;
			D_Imm16 <= Imm16_Inter;
			D_InstrBus <= InstrBus_Inter;
			D_T <= T_Inter==4'b0	?	4'b0	:	T_Inter-1;
			D_WriteRegEnable <= WriteRegEnable_Inter;
			D_RegId <= WriteRegId_Inter;
			D_MultCalFamily <= MultCalFamily_Inter;
		end
    end
    
endmodule
