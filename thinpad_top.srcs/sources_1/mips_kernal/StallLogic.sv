`timescale 1ns / 1ps
`include "Common.sv"

module StallLogic(
    input logic [`InstrBusWidth]	InstrBus,
    input logic [4:0] Rs,
    input logic [4:0] Rt,
    input logic [3:0]   D_T,
    input logic 	WE_D,
    input logic [4:0]   D_RegId,
    input logic [3:0]   E_T,
    input logic		WE_E,
    input logic [4:0]   E_RegId,
	input logic ALUwithHILO,
	input logic D_MultCalFamily,
    output logic stall,
    output logic [3:0]   OUTT
    );
	assign	{`InstrBusWireSet}	=	InstrBus;

      logic NeedRs=`InstrsUseRs;
	  logic NeedRt=`InstrsUseRt;

      logic [3:0] T_Rs=`OutForRs;
																														
	  logic [3:0] T_Rt=`OutForRt;
	  logic MultFamily = `MCycleInstrs;
      /////////////////////////////////////////////////////////////
      logic  stall_Rs = NeedRs && Rs!=5'b0 &&( (WE_D && D_T>T_Rs && D_RegId==Rs)|| (WE_E && E_T>T_Rs && E_RegId==Rs)),
             stall_Rt = NeedRt && Rt!=5'b0 &&( (WE_D && D_T>T_Rt && D_RegId==Rt)|| (WE_E && E_T>T_Rt && E_RegId==Rt)),
	         stall_XALU = ((ALUwithHILO&MultFamily)|(MultFamily&D_MultCalFamily));
      assign stall  = (stall_Rs||stall_Rt|stall_XALU);
      assign OUTT = `OutForNew;

endmodule
