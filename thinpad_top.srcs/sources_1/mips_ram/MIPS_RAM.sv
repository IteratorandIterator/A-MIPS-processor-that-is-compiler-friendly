`timescale 1ns / 1ps
`include "Common.sv"

module MIPS_RAM(
        input logic clk,
        input logic rst,
        input logic [31:0]  MEM_IN1,
        input logic [31:0]  MEM_IN2,
        input logic [4:0]   MEM_IN3,
        input logic [31:0]  MEM_IN4,
        output logic [31:0]  MEM_OUT2,    //直接输出
        input logic [31:0]  MEM_IN5,
        input logic         MEM_IN6,
        input logic  [4:0]   MEM_IN7,
         output logic [31:0]  MEM_OUT1, //直接输出
        input logic MEM_IN8,
        input logic MEM_IN9,
        input logic MEM_IN10,
        input logic MEM_IN11,
        input logic MEM_IN12,

        input logic [31:0] MEM_IN13,
        input logic [31:0] MEM_IN14,
        output logic txd,  //直接输出
        input  logic rxd, 
        input logic MEM_IN15,
        input logic [4:0] MEM_IN16,
        input logic MEM_IN17
    );

    logic    [31:0]  MF_Rt = MEM_IN15				?   MEM_OUT2:
															MEM_IN2;
    logic [31:0] MemReadData_Inter = MEM_IN5;
    logic [31:0] Data_to_next_state = MEM_IN6 ? MemReadData_Inter:MEM_IN4;
    logic [1:0]  Offset_Inter = MEM_IN4[1:0];
    assign  MEM_OUT1 = MF_Rt<<{Offset_Inter,3'b0};


    
    logic          TxD_valid = MEM_IN11;
    logic          TxD_ready;
    logic   [7:0]  TxD_din = MEM_OUT1[7:0];

    logic          RxD_ready = MEM_IN10;
    logic          RxD_valid;
    logic  [7:0]   RxD_dout;

    logic [31:0] UART_DATA = {24'b0,RxD_dout};
    logic [31:0] UART_STATUS = {30'b0,RxD_valid,TxD_ready};
    ///////////////////////UART_Unit/////////////////////
    logic RxD_data_ready;
    logic RxD_clear;
    logic [7:0] RxD_data;

    logic TxD_busy;
    logic TxD_start;
    logic [7:0] TxD_data;

    logic RXD_FIFO_wr_en;
    logic RXD_FIFO_full;
    logic [7:0] RXD_FIFO_din;
    logic RXD_FIFO_rd_en;
    logic RXD_FIFO_empty;
    logic [7:0] RXD_FIFO_dout;

    logic TXD_FIFO_wr_en;
    logic TXD_FIFO_full;
    logic [7:0] TXD_FIFO_din;
    logic TXD_FIFO_rd_en;
    logic TXD_FIFO_empty;
    logic [7:0] TXD_FIFO_dout;

    assign TxD_ready = ~TXD_FIFO_full;
    assign RxD_valid = ~RXD_FIFO_empty;
    assign RxD_dout = RXD_FIFO_dout;
   

    assign RxD_clear = (RxD_data_ready&&(~RXD_FIFO_full))||rst;//收到数据，且FIFO没满，就能继续装
     
    assign TxD_start = (~TxD_busy)&&(~TXD_FIFO_empty);//FIFO不空，且不忙的时候就发�??
    assign TxD_data = TXD_FIFO_dout;//来自FIFO的数�????

    assign RXD_FIFO_wr_en = RxD_clear;//清空的同时写�????
    assign RXD_FIFO_din = RxD_data;//接收端的数据   
    assign RXD_FIFO_rd_en = RxD_ready;
    
    assign TXD_FIFO_wr_en = TxD_valid;
    assign TXD_FIFO_din   = TxD_din; 
    assign TXD_FIFO_rd_en = TxD_start;//进行发�??

    logic [9:0]  RXD_FIFO_rd_data_count,RXD_FIFO_wr_data_count,TXD_FIFO_rd_data_count,TXD_FIFO_wr_data_count;
    async_receiver #(.ClkFrequency(`ClkFrequency),.Baud(`Baud))  //接收模块�????9600无检验位
    uart_r(
        .clk(clk),                       //外部时钟信号
        .RxD(rxd),                           //外部串行信号输入
        .RxD_data_ready(RxD_data_ready),  //数据接收到标�????
        .RxD_clear(RxD_clear),       //清除接收标志
        .RxD_data(RxD_data)             //接收到的�????字节数据
    );
    async_transmitter #(.ClkFrequency(`ClkFrequency),.Baud(`Baud))  //发�?�模块，9600无检验位
    uart_t(
        .clk(clk),                  //外部时钟信号
        .TxD(txd),                      //串行信号输出
        .TxD_busy(TxD_busy),       //发�?�器忙状态指�????
        .TxD_start(TxD_start),    //�????始发送信�????
        .TxD_data(TxD_data)        //待发送的数据
    );


    fifo_generator_0 RXD_FIFO (
        .rst(rst),                  // input wire rst
        .clk(clk),            // input wire wr_clk
        .wr_en(RXD_FIFO_wr_en),              // input wire wr_en
        .din(RXD_FIFO_din),                  // input wire [7 : 0] din
        .full(RXD_FIFO_full),                // output wire full

        .rd_en(RXD_FIFO_rd_en),              // input wire rd_en
        .dout(RXD_FIFO_dout),                // output wire [7 : 0] dout
        .empty(RXD_FIFO_empty)              // output wire empty
        );
   fifo_generator_0 TXD_FIFO (
        .rst(rst),                  // input wire rst
        .clk(clk),            // input wire wr_clk
        .wr_en(TXD_FIFO_wr_en),              // input wire wr_en
        .din(TXD_FIFO_din),                  // input wire [7 : 0] din
        .full(TXD_FIFO_full),                // output wire full


        .rd_en(TXD_FIFO_rd_en),              // input wire rd_en
        .dout(TXD_FIFO_dout),                // output wire [7 : 0] dout
        .empty(TXD_FIFO_empty)              // output wire empty
        );

    ///////////////////////UART_Unit/////////////////////

    logic [1:0] M_Offset;
    logic [4:0] M_ExtType;
    logic [31:0] M_ALU_Data;
    logic [31:0] M_Base_Data;
    logic [31:0] M_Ext_Data;
    logic [31:0] M_UART_DATA;
    logic [31:0] M_UART_STATUS;
	logic		M_MemReadEnable;
    logic [31:0] M_RawData;

    logic M_Reading_base;
    logic M_Reading_ext;
    logic M_reading_UART_DATA;
    logic M_reading_UART_STATUS;
    always_ff @(posedge clk) begin
		if(rst) begin
			M_Offset <= 0;
			M_ExtType <= 0;
			M_MemReadEnable <= 0;
            M_ALU_Data <= 0;
            M_Base_Data<=0;
            M_Ext_Data <=0;
            M_UART_DATA<=0;
            M_UART_STATUS<=0;

            M_Reading_base<=0;
            M_Reading_ext<=0;
            M_reading_UART_DATA<=0;
            M_reading_UART_STATUS<=0;
		end
		else begin
			M_Offset <= Offset_Inter;
			M_ExtType <= MEM_IN7;
			M_MemReadEnable <= MEM_IN6;
            M_ALU_Data <=MEM_IN17?MEM_IN16:MEM_IN4;
            M_Base_Data<=MEM_IN13;
            M_Ext_Data <=MEM_IN14;
            M_UART_DATA<=UART_DATA;
            M_UART_STATUS<=UART_STATUS;

            M_Reading_base<=~MEM_IN8;
            M_Reading_ext<=~MEM_IN9;
            M_reading_UART_DATA<=MEM_IN10;
            M_reading_UART_STATUS<=MEM_IN12;
            M_RawData = ~MEM_IN9    ?   MEM_IN14:
                        ~MEM_IN8   ?   MEM_IN13:
                        MEM_IN10 ?   UART_DATA:
                                                UART_STATUS;

		end
    end
    //////////////////////////////////////
	logic [31:0] ExtMemData;
    logic lb,lbu,lh,lhu,lw;
    assign {lb,lbu,lh,lhu,lw}=M_ExtType;
    
    logic [31:0] OffsetedData =  M_RawData>>({M_Offset,3'b0});
    assign ExtMemData = lhu ?   {16'b0,OffsetedData[15:0]}:
                        lh  ?   {{16{OffsetedData[15]}},OffsetedData[15:0]}:
                        lbu ?   {24'b0,OffsetedData[7:0]}:
                        lb  ?   {{24{OffsetedData[7]}},OffsetedData[7:0]}:
                                OffsetedData;

    assign MEM_OUT2 = M_MemReadEnable ? ExtMemData:M_ALU_Data;
endmodule
