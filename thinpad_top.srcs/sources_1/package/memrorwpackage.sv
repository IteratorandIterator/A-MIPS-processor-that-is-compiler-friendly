package memorypackage;
    typedef struct packed {
        logic	[31:0]	E_Mem_read_data;
	    logic	[31:0]	base_data;
	    logic	[31:0]	ext_data;
    } MIPSRAMInfo;
endpackage