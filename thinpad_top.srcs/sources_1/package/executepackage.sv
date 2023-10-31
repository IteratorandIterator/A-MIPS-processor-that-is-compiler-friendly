package executepackage;
    typedef struct packed {
        logic [31:0] E_PC;
	    logic [31:0] E_WriteMemData;
	    logic [31:0]	E_MemWriteData_MFed;
	    logic [4:0] E_RtID;

	    logic [3:0] E_MemBitEnable;
	    logic E_MemReadEnable;
	    logic E_MemWriteEnable;
	        logic [4:0] E_ExtType;
	    logic E_Reading_base_n;
	    logic E_Writing_base_n;
	    logic E_Using_base;
	    logic [3:0]  E_base_be_n;
	    logic [31:0] E_base_addr;

	    logic E_Reading_ext_n;
	    logic E_Writing_ext_n;
	    logic E_Using_ext;
	    logic [3:0]  E_ext_be_n;
	    logic [31:0] E_ext_addr;

	    logic E_Reading_UART_Data;
	    logic E_Writing_UART_Data;
	    logic E_Reading_UART_STATUS;
	    logic [4:0] E_CNT_Pass;
	    logic E_slti_reg;
    } ExecuteInfo;
endpackage