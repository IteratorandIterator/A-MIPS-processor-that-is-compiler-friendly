package fetchpackage;

    typedef struct packed {
        logic [31:0]	D_Instr,E_Instr;
	    logic I_sram_busy;
	    logic D_stall_Pass;
	    logic [31:0] D_NewPC_Pass,I_PC_Pass;
	    logic [31:0] I_PC,I_Instr;
	    logic [31:0]	I_sram_data;
	    logic [31:0] I_next_pc_pass;
    } FetchInfo;

endpackage