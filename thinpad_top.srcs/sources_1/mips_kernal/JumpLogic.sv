`timescale 1ns / 1ps
`include "Common.sv"
module JumpLogic(
    input  logic rst,
    input logic [31:0]	CurrentInstr,
    input logic signed  [31:0]  RsData,
    input logic signed  [31:0]  RtData,
    input logic [31:0]  CurrentPC,

    output logic[31:0]  TargetPC
    );
    JumpLogic_P::JBInstrInfo JBInstrInfo = {CurrentInstr[`IMM16BITS], CurrentInstr[`IMM26BITS],
                                            CurrentInstr[`OpCodeBITS],CurrentInstr[`FunctBITS],
                                            CurrentPC + 32'b100};
    JumpLogic_P::JJudge JJudge = {(JBInstrInfo.OpCode==6'h2 | JBInstrInfo.OpCode==6'h3), 
                                  {CurrentPC[31:28],JBInstrInfo.Imm26,2'b00}};
    JumpLogic_P::JRJudge JRJudge = {((JBInstrInfo.OpCode==6'h0 && JBInstrInfo.Funct==6'h8) | 
                                    (JBInstrInfo.OpCode==6'h0 && JBInstrInfo.Funct==6'h9)),
                                    RsData};
    logic beq=	(JBInstrInfo.OpCode==6'h4),
		  bne=	(JBInstrInfo.OpCode==6'h5),
		  blez=	(JBInstrInfo.OpCode==6'h6),
		  bgtz=	(JBInstrInfo.OpCode==6'h7),
		  bltz=	(CurrentInstr[31:26]==6'h1 && CurrentInstr[20:16]==6'h0),
		  bgez=	(CurrentInstr[31:26]==6'h1 && CurrentInstr[20:16]==6'h1);    
    logic Is_BType = (beq|bne|blez)|(bgtz|bltz|bgez);
    logic Is_True = beq ? RsData==RtData: bne ? RsData!=RtData: blez ? RsData<=0: bgtz ? RsData>0:
                    bltz ? RsData<0: bgez ? RsData>=0: 1'b0;
    JumpLogic_P::BJudge BJudge = {Is_BType, Is_True, {CurrentPC  +   {{14{JBInstrInfo.Imm16[15]}},JBInstrInfo.Imm16,2'b00}}};
    assign  TargetPC = rst ? 32'h8000_0000:JJudge.Is_JType?JJudge.J_Target:
                        JRJudge.Is_JRType?JRJudge.JR_Target:
                        (BJudge.Is_BType & BJudge.Is_True)?BJudge.B_Target:JBInstrInfo.PCPlus4;
endmodule
