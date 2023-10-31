`timescale 1ns / 1ps

module thinpad_top(
    input logic clk_50M,           //50MHz 时钟输入
    input logic clk_11M0592,       //11.0592MHz 时钟输入（备用，可不用）

    input logic clock_btn,         //BTN5手动时钟按钮�?关，带消抖电路，按下时为1
    input logic reset_btn,         //BTN6手动复位按钮�?关，带消抖电路，按下时为1

    input  logic[3:0]  touch_btn,  //BTN1~BTN4，按钮开关，按下时为1
    input  logic[31:0] dip_sw,     //32位拨码开关，拨到“ON”时�?1
    output logic[15:0] leds,       //16位LED，输出时1点亮
    output logic[7:0]  dpy0,       //数码管低位信号，包括小数点，输出1点亮
    output logic[7:0]  dpy1,       //数码管高位信号，包括小数点，输出1点亮

    //BaseRAM信号
    inout logic[31:0] base_ram_data,  //BaseRAM数据，低8位与CPLD串口控制器共�?
    output logic[19:0] base_ram_addr, //BaseRAM地址
    output logic[3:0] base_ram_be_n,  //BaseRAM字节使能，低有效。如果不使用字节使能，请保持�?0
    output logic base_ram_ce_n,       //BaseRAM片�?�，低有�?
    output logic base_ram_oe_n,       //BaseRAM读使能，低有�?
    output logic base_ram_we_n,       //BaseRAM写使能，低有�?

    //ExtRAM信号
    inout logic[31:0] ext_ram_data,  //ExtRAM数据
    output logic[19:0] ext_ram_addr, //ExtRAM地址
    output logic[3:0] ext_ram_be_n,  //ExtRAM字节使能，低有效。如果不使用字节使能，请保持�?0
    output logic ext_ram_ce_n,       //ExtRAM片�?�，低有�?
    output logic ext_ram_oe_n,       //ExtRAM读使能，低有�?
    output logic ext_ram_we_n,       //ExtRAM写使能，低有�?

    //直连串口信号
    output logic txd,  //直连串口发�?�端
    input  logic rxd,  //直连串口接收�?

    //Flash存储器信号，参�?? JS28F640 芯片手册
    output logic [22:0]flash_a,      //Flash地址，a0仅在8bit模式有效�?16bit模式无意�?
    inout  logic [15:0]flash_d,      //Flash数据
    output logic flash_rp_n,         //Flash复位信号，低有效
    output logic flash_vpen,         //Flash写保护信号，低电平时不能擦除、烧�?
    output logic flash_ce_n,         //Flash片�?�信号，低有�?
    output logic flash_oe_n,         //Flash读使能信号，低有�?
    output logic flash_we_n,         //Flash写使能信号，低有�?
    output logic flash_byte_n,       //Flash 8bit模式选择，低有效。在使用flash�?16位模式时请设�?1

    //图像输出信号
    output logic[2:0] video_red,    //红色像素�?3�?
    output logic[2:0] video_green,  //绿色像素�?3�?
    output logic[1:0] video_blue,   //蓝色像素�?2�?
    output logic video_hsync,       //行同步（水平同步）信�?
    output logic video_vsync,       //场同步（垂直同步）信�?
    output logic video_clk,         //像素时钟输出
    output logic video_de           //行数据有效信号，用于区分消隐�?
);

/* =========== Demo code begin =========== */

// PLL分频示例
    logic locked, clk_10M, clk_20M;
    clk_wiz_0 clock_gen (
    // Clock in ports
        .clk_in1(clk_50M),  // 外部时钟输入
  // Clock out ports
        .clk_out1(clk_10M), // 时钟输出1，频率在IP配置界面中设�?
        .clk_out2(clk_20M), // 时钟输出2，频率在IP配置界面中设�?
  // Status and control signals
        .reset(reset_btn), // PLL复位输入
        .locked(locked)    // PLL锁定指示输出�?"1"表示时钟稳定�?
                     // 后级电路复位信号应当由它生成（见下）
    );

logic reset_of_clk10M;
// 异步复位，同步释放，将locked信号转为后级电路的复位reset_of_clk10M
always_ff @(posedge clk_10M or negedge locked) begin
    if(~locked) reset_of_clk10M <= 1'b1;
    else        reset_of_clk10M <= 1'b0;
end

    logic [31:0] UART_STATUS_out,UART_DATA_out;
    MIPS_KERNAL MIPS_KERNAL(
        .clk(clk_10M),
        .rst(reset_of_clk10M),
        .base_ram_data(base_ram_data),
        .base_ram_addr(base_ram_addr),
        .base_ram_be_n(base_ram_be_n),
        .base_ram_ce_n(base_ram_ce_n),
        .base_ram_oe_n(base_ram_oe_n),
        .base_ram_we_n(base_ram_we_n),
        .ext_ram_data(ext_ram_data),
        .ext_ram_addr(ext_ram_addr),
        .ext_ram_be_n(ext_ram_be_n),
        .ext_ram_ce_n(ext_ram_ce_n),
        .ext_ram_oe_n(ext_ram_oe_n),
        .ext_ram_we_n(ext_ram_we_n),
        .txd(txd),
        .rxd(rxd));


endmodule
