`timescale 1ns / 1ps
`include "Common.sv"

module MIPS_KERNAL(
	input  logic clk,
	input  logic rst,
	inout  logic [31:0] base_ram_data,  //BaseRAM数据，低8位与CPLD串口控制器共�?????
    output logic [19:0] base_ram_addr, //BaseRAM地址
    output logic [3:0] base_ram_be_n,  //BaseRAM字节使能，低有效。如果不使用字节使能，请保持�?????0
    output logic  base_ram_ce_n,       //BaseRAM片�?�，低有�?????
    output logic  base_ram_oe_n,       //BaseRAM读使能，低有�?????
    output logic  base_ram_we_n,      //BaseRAM写使能，低有�?????
	 //ExtRAM信号
    inout  logic [31:0] ext_ram_data,  //ExtRAM数据
    output logic [19:0] ext_ram_addr, //ExtRAM地址
    output logic [3:0] ext_ram_be_n,  //ExtRAM字节使能，低有效。如果不使用字节使能，请保持�?????0
    output logic  ext_ram_ce_n,       //ExtRAM片�?�，低有�?????
    output logic  ext_ram_oe_n,       //ExtRAM读使能，低有�?????
    output logic  ext_ram_we_n,       //ExtRAM写使能，低有�?????

	output logic txd,  //直连串口发�?�端
    input  logic rxd  //直连串口接收�?????
    );
	
	fetchpackage::FetchInfo FetchInfo;
	assign FetchInfo.I_sram_data = base_ram_data;
	Fetch Fetch(.clk(clk),
				.rst(rst),
				.FETCH_IN1(FetchInfo.D_stall_Pass),
				.FETCH_IN2(FetchInfo.D_NewPC_Pass),
				.FETCH_OUT1(FetchInfo.I_PC),
				.FETCH_OUT2(FetchInfo.I_PC_Pass),
				.FETCH_OUT3(FetchInfo.I_Instr),
				.FETCH_IN3(FetchInfo.I_sram_data),
				.FETCH_IN4(FetchInfo.I_sram_busy),
				.FETCH_OUT4(FetchInfo.I_next_pc_pass));

	decodepackage::DecodeInfo DecodeInfo;
	Decode Decode(
		.clk(clk),
		.rst(rst),
		.W_WriteRegEnable(DecodeInfo.M_WriteRegEnable),
		.W_RegWriteId(DecodeInfo.M_RegId),
		.W_RegWriteData(DecodeInfo.M_Data),
		.I_PC_Pass(FetchInfo.I_PC_Pass),
		.I_PC(FetchInfo.I_PC),
		.I_MipsInstr(FetchInfo.I_Instr),
		.W_PC(DecodeInfo.M_PC),
		.D_NewPC_Pass(FetchInfo.D_NewPC_Pass),
		.D_PC(DecodeInfo.D_PC),
		.D_RsID(DecodeInfo.D_RsID),
		.D_RtID(DecodeInfo.D_RtID),
		.D_RsData(DecodeInfo.D_RsData),
		.D_RtData(DecodeInfo.D_RtData),
		.D_Shamt(DecodeInfo.D_Shamt),
		.D_Imm16(DecodeInfo.D_Imm16),
		.D_InstrBus(DecodeInfo.D_InstrBus),
		.E_T(DecodeInfo.E_T),
		.E_WriteRegEnable(DecodeInfo.E_WriteRegEnable),
		.E_RegId(DecodeInfo.E_RegId),
		.E_Data(DecodeInfo.E_Data),
		.D_T(DecodeInfo.D_T),
		.D_WriteRegEnable(DecodeInfo.D_WriteRegEnable),
		.D_RegId(DecodeInfo.D_RegId),
		.D_stall_Pass(FetchInfo.D_stall_Pass),
		.E_XALU_Busy(DecodeInfo.E_XALU_Busy),
		.I_sram_busy(FetchInfo.I_sram_busy),
		.D_Instr(FetchInfo.D_Instr));
	
	executepackage::ExecuteInfo ExecuteInfo;
	Execute Execute(
		.clk(clk),
		.rst(rst),
		.EXE_IN1(DecodeInfo.D_PC),
		.EXE_IN2(FetchInfo.D_Instr),
		.EXE_IN3(DecodeInfo.D_RsID),
		.EXE_IN4(DecodeInfo.D_RtID),
		.EXE_IN5(DecodeInfo.D_RsData),
		.EXE_IN6(DecodeInfo.D_RtData),
		.EXE_IN7(DecodeInfo.D_Shamt),
		.EXE_IN8(DecodeInfo.D_Imm16),
		.EXE_IN9(DecodeInfo.D_InstrBus),
		.EXE_IN10(DecodeInfo.D_T),
		.EXE_IN11(DecodeInfo.D_WriteRegEnable),
		.EXE_IN12(DecodeInfo.D_RegId),
		.EXE_IN13(DecodeInfo.M_WriteRegEnable),
		.EXE_IN14(DecodeInfo.M_RegId),
		.EXE_IN15(DecodeInfo.M_Data),
		.EXE_OUT1(ExecuteInfo.E_PC),
		.EXE_OUT2(FetchInfo.E_Instr),
		.EXE_OUT3(ExecuteInfo.E_WriteMemData),
		.EXE_OUT4(ExecuteInfo.E_RtID),
		.EXE_OUT5(DecodeInfo.E_T),
		.EXE_OUT6(DecodeInfo.E_WriteRegEnable),
		.EXE_OUT7(DecodeInfo.E_RegId),
		.EXE_OUT8(DecodeInfo.E_Data),
		
		.EXE_OUT9(ExecuteInfo.E_MemBitEnable),
		.EXE_OUT10(ExecuteInfo.E_MemReadEnable),
		.EXE_OUT11(ExecuteInfo.E_MemWriteEnable),
		.EXE_OUT12(ExecuteInfo.E_ExtType),
		.EXE_OUT13(DecodeInfo.E_XALU_Busy),
		
		

		.EXE_IN16(FetchInfo.I_next_pc_pass),
		.EXE_OUT14(ExecuteInfo.E_Reading_base_n),
		.EXE_OUT15(ExecuteInfo.E_Writing_base_n),
		.EXE_OUT16(ExecuteInfo.E_Using_base),
		.EXE_OUT17(ExecuteInfo.E_base_be_n),
		.EXE_OUT18(ExecuteInfo.E_base_addr),
		.EXE_OUT19(ExecuteInfo.E_Reading_ext_n),
		.EXE_OUT20(ExecuteInfo.E_Writing_ext_n),
		.EXE_OUT21(ExecuteInfo.E_Using_ext),
		.EXE_OUT22(ExecuteInfo.E_ext_be_n),
		.EXE_OUT23(ExecuteInfo.E_ext_addr),

		.EXE_OUT24(ExecuteInfo.E_Reading_UART_Data),
		.EXE_OUT25(ExecuteInfo.E_Writing_UART_Data),
		.EXE_OUT26(ExecuteInfo.E_Reading_UART_STATUS),
		.EXE_OUT27(E_M_FM_singal),
		.EXE_OUT28(FetchInfo.I_sram_busy),
		
		.EXE_OUT29(ExecuteInfo.E_CNT_Pass),
		.EXE_OUT30(ExecuteInfo.E_slti_reg));


	memorypackage::MIPSRAMInfo MIPSRAMInfo;
	assign MIPSRAMInfo.base_data = base_ram_data;
	assign MIPSRAMInfo.ext_data  = ext_ram_data;
	MIPS_RAM MIPS_RAM(	
		.clk(clk),
		.rst(rst),
		.MEM_IN1(FetchInfo.E_Instr),
		.MEM_IN2(ExecuteInfo.E_WriteMemData),
		.MEM_IN3(ExecuteInfo.E_RtID),
		.MEM_IN4(DecodeInfo.E_Data),
		.MEM_OUT2(DecodeInfo.M_Data),
		.MEM_IN5(MIPSRAMInfo.E_Mem_read_data),
		.MEM_IN6(ExecuteInfo.E_MemReadEnable),
		.MEM_IN7(ExecuteInfo.E_ExtType),
		.MEM_OUT1(ExecuteInfo.E_MemWriteData_MFed),
		.MEM_IN8(ExecuteInfo.E_Reading_base_n),
		.MEM_IN9(ExecuteInfo.E_Reading_ext_n),
		.MEM_IN10(ExecuteInfo.E_Reading_UART_Data),
		.MEM_IN11(ExecuteInfo.E_Writing_UART_Data),
		.MEM_IN12(ExecuteInfo.E_Reading_UART_STATUS),
		.MEM_IN13(MIPSRAMInfo.base_data),
		.MEM_IN14(MIPSRAMInfo.ext_data),
		.txd(txd),
		.rxd(rxd),
		.MEM_IN15(E_M_FM_singal),
		.MEM_IN16(ExecuteInfo.E_CNT_Pass),
		.MEM_IN17(ExecuteInfo.E_slti_reg));

	WriteBack WriteBack(
		.clk(clk),
		.rst(rst),
		.WB_IN1(DecodeInfo.E_WriteRegEnable),
		.WB_IN2(DecodeInfo.E_RegId),
		.WB_IN3(ExecuteInfo.E_PC),
		.WB_OUT1(DecodeInfo.M_WriteRegEnable),
		.WB_OUT2(DecodeInfo.M_RegId),
		.WB_OUT3(DecodeInfo.M_PC));

    function logic [68:0] base_info;
		return {ExecuteInfo.E_Writing_base_n?{32{1'bz}}:ExecuteInfo.E_MemWriteData_MFed, ExecuteInfo.E_base_addr[21:2], ExecuteInfo.E_base_be_n,
		          1'b0, ~ExecuteInfo.E_Writing_base_n, ExecuteInfo.E_Writing_base_n};
	endfunction

	function logic [68:0] ext_info;
		return {ExecuteInfo.E_Writing_ext_n?{32{1'bz}}:ExecuteInfo.E_MemWriteData_MFed, ExecuteInfo.E_ext_addr[21:2],
		          ExecuteInfo.E_ext_be_n, 1'b0, ExecuteInfo.E_Reading_ext_n, ExecuteInfo.E_Writing_ext_n};
	endfunction

	assign {base_ram_data, base_ram_addr, base_ram_be_n, base_ram_ce_n,
	base_ram_oe_n, base_ram_we_n} =  base_info();
	assign {ext_ram_data, ext_ram_addr, ext_ram_be_n, ext_ram_ce_n,
	ext_ram_oe_n, ext_ram_we_n} = ext_info();

endmodule
