package decodepackage;
    typedef struct packed {
        logic M_WriteRegEnable;
	    logic [4:0] D_RsID,D_RtID;
	    logic [31:0] D_RsData,D_RtData;
	    logic [4:0] D_Shamt;
	    logic [15:0] D_Imm16;
	    logic [`InstrBusWidth] D_InstrBus;
	    logic [31:0]	D_PC,M_PC;
	    logic [3:0] E_T,D_T;
	    logic E_WriteRegEnable,D_WriteRegEnable;
	    logic [4:0] E_RegId,D_RegId;
	    logic [31:0] E_Data;
	    logic E_XALU_Busy;
	    logic [4:0] M_RegId;
	    logic [31:0] M_Data;
    } DecodeInfo;
endpackage

package DecodeLogic_P;
    
endpackage

package JumpLogic_P;
    typedef struct packed {
        logic    [15:0]  Imm16;
        logic    [25:0]  Imm26;
        logic	 [5:0]	 OpCode;
        logic	 [5:0]	 Funct;
        logic    [31:0]  PCPlus4;
    } JBInstrInfo;
    typedef struct packed {
        logic    Is_JType;
        logic    [31:0]  J_Target;
    } JJudge;
    typedef struct packed {
        logic    Is_JRType;
        logic    [31:0]  JR_Target;
    } JRJudge;
    typedef struct packed {
        logic    Is_BType;
        logic    Is_True;
        logic    [31:0]	B_Target;
    } BJudge;
endpackage

package StallLogic_P;
    typedef struct packed {
        logic NeedRs;
	    logic NeedRt;
        logic [3:0] T_Rs;
	    logic [3:0] T_Rt;																						
	    logic MultFamily;
    } StallInfo;
endpackage