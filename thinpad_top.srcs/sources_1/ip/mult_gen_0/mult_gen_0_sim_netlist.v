// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
// Date        : Fri Aug  4 21:32:01 2023
// Host        : LAPTOP-07DUCPKN running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               E:/LongArch-Competetion/HFUT-MIPS-ZLX/v1.0/thinpad_top.srcs/sources_1/ip/mult_gen_0/mult_gen_0_sim_netlist.v
// Design      : mult_gen_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a200tfbg676-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "mult_gen_0,mult_gen_v12_0_16,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "mult_gen_v12_0_16,Vivado 2019.2" *) 
(* NotValidForBitStream *)
module mult_gen_0
   (A,
    B,
    P);
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME a_intf, LAYERED_METADATA undef" *) input [31:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME b_intf, LAYERED_METADATA undef" *) input [31:0]B;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME p_intf, LAYERED_METADATA undef" *) output [31:0]P;

  wire [31:0]A;
  wire [31:0]B;
  wire [31:0]P;
  wire [47:0]NLW_U0_PCASC_UNCONNECTED;
  wire [1:0]NLW_U0_ZERO_DETECT_UNCONNECTED;

  (* C_A_TYPE = "0" *) 
  (* C_A_WIDTH = "32" *) 
  (* C_B_TYPE = "0" *) 
  (* C_B_VALUE = "10000001" *) 
  (* C_B_WIDTH = "32" *) 
  (* C_CCM_IMP = "0" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_ZERO_DETECT = "0" *) 
  (* C_LATENCY = "0" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_MULT_TYPE = "1" *) 
  (* C_OPTIMIZE_GOAL = "1" *) 
  (* C_OUT_HIGH = "31" *) 
  (* C_OUT_LOW = "0" *) 
  (* C_ROUND_OUTPUT = "0" *) 
  (* C_ROUND_PT = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  mult_gen_0_mult_gen_v12_0_16 U0
       (.A(A),
        .B(B),
        .CE(1'b1),
        .CLK(1'b1),
        .P(P),
        .PCASC(NLW_U0_PCASC_UNCONNECTED[47:0]),
        .SCLR(1'b0),
        .ZERO_DETECT(NLW_U0_ZERO_DETECT_UNCONNECTED[1:0]));
endmodule

(* C_A_TYPE = "0" *) (* C_A_WIDTH = "32" *) (* C_B_TYPE = "0" *) 
(* C_B_VALUE = "10000001" *) (* C_B_WIDTH = "32" *) (* C_CCM_IMP = "0" *) 
(* C_CE_OVERRIDES_SCLR = "0" *) (* C_HAS_CE = "0" *) (* C_HAS_SCLR = "0" *) 
(* C_HAS_ZERO_DETECT = "0" *) (* C_LATENCY = "0" *) (* C_MODEL_TYPE = "0" *) 
(* C_MULT_TYPE = "1" *) (* C_OPTIMIZE_GOAL = "1" *) (* C_OUT_HIGH = "31" *) 
(* C_OUT_LOW = "0" *) (* C_ROUND_OUTPUT = "0" *) (* C_ROUND_PT = "0" *) 
(* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "artix7" *) (* ORIG_REF_NAME = "mult_gen_v12_0_16" *) 
(* downgradeipidentifiedwarnings = "yes" *) 
module mult_gen_0_mult_gen_v12_0_16
   (CLK,
    A,
    B,
    CE,
    SCLR,
    ZERO_DETECT,
    P,
    PCASC);
  input CLK;
  input [31:0]A;
  input [31:0]B;
  input CE;
  input SCLR;
  output [1:0]ZERO_DETECT;
  output [31:0]P;
  output [47:0]PCASC;

  wire \<const0> ;
  wire [31:0]A;
  wire [31:0]B;
  wire [31:0]P;
  wire [47:0]NLW_i_mult_PCASC_UNCONNECTED;
  wire [1:0]NLW_i_mult_ZERO_DETECT_UNCONNECTED;

  assign PCASC[47] = \<const0> ;
  assign PCASC[46] = \<const0> ;
  assign PCASC[45] = \<const0> ;
  assign PCASC[44] = \<const0> ;
  assign PCASC[43] = \<const0> ;
  assign PCASC[42] = \<const0> ;
  assign PCASC[41] = \<const0> ;
  assign PCASC[40] = \<const0> ;
  assign PCASC[39] = \<const0> ;
  assign PCASC[38] = \<const0> ;
  assign PCASC[37] = \<const0> ;
  assign PCASC[36] = \<const0> ;
  assign PCASC[35] = \<const0> ;
  assign PCASC[34] = \<const0> ;
  assign PCASC[33] = \<const0> ;
  assign PCASC[32] = \<const0> ;
  assign PCASC[31] = \<const0> ;
  assign PCASC[30] = \<const0> ;
  assign PCASC[29] = \<const0> ;
  assign PCASC[28] = \<const0> ;
  assign PCASC[27] = \<const0> ;
  assign PCASC[26] = \<const0> ;
  assign PCASC[25] = \<const0> ;
  assign PCASC[24] = \<const0> ;
  assign PCASC[23] = \<const0> ;
  assign PCASC[22] = \<const0> ;
  assign PCASC[21] = \<const0> ;
  assign PCASC[20] = \<const0> ;
  assign PCASC[19] = \<const0> ;
  assign PCASC[18] = \<const0> ;
  assign PCASC[17] = \<const0> ;
  assign PCASC[16] = \<const0> ;
  assign PCASC[15] = \<const0> ;
  assign PCASC[14] = \<const0> ;
  assign PCASC[13] = \<const0> ;
  assign PCASC[12] = \<const0> ;
  assign PCASC[11] = \<const0> ;
  assign PCASC[10] = \<const0> ;
  assign PCASC[9] = \<const0> ;
  assign PCASC[8] = \<const0> ;
  assign PCASC[7] = \<const0> ;
  assign PCASC[6] = \<const0> ;
  assign PCASC[5] = \<const0> ;
  assign PCASC[4] = \<const0> ;
  assign PCASC[3] = \<const0> ;
  assign PCASC[2] = \<const0> ;
  assign PCASC[1] = \<const0> ;
  assign PCASC[0] = \<const0> ;
  assign ZERO_DETECT[1] = \<const0> ;
  assign ZERO_DETECT[0] = \<const0> ;
  GND GND
       (.G(\<const0> ));
  (* C_A_TYPE = "0" *) 
  (* C_A_WIDTH = "32" *) 
  (* C_B_TYPE = "0" *) 
  (* C_B_VALUE = "10000001" *) 
  (* C_B_WIDTH = "32" *) 
  (* C_CCM_IMP = "0" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_ZERO_DETECT = "0" *) 
  (* C_LATENCY = "0" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_MULT_TYPE = "1" *) 
  (* C_OPTIMIZE_GOAL = "1" *) 
  (* C_OUT_HIGH = "31" *) 
  (* C_OUT_LOW = "0" *) 
  (* C_ROUND_OUTPUT = "0" *) 
  (* C_ROUND_PT = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  mult_gen_0_mult_gen_v12_0_16_viv i_mult
       (.A(A),
        .B(B),
        .CE(1'b0),
        .CLK(1'b1),
        .P(P),
        .PCASC(NLW_i_mult_PCASC_UNCONNECTED[47:0]),
        .SCLR(1'b0),
        .ZERO_DETECT(NLW_i_mult_ZERO_DETECT_UNCONNECTED[1:0]));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2019.1"
`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="cds_rsa_key", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=64)
`pragma protect key_block
HPMPLvpmoX7LOmPj78BMT9X1rCnPz6PdhVGZQ307N9haGfAdMGVirvGR3e0Glyn2ieoWqXA6qOQL
t0xn28+h0g==

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
Nxv/BnutRgdmHnLyK7kvDGjm7WGfFKW2mxQ6xUKF14zS4ziz5pSV0ueW4VqAzUyEPsErIAEuyV6F
m5KCqRBB197Q2NbZa7O7tdAqboX6tPAJzbB6u4U/MmNS1AQcSgtfj5srMbdBzDa5pR4V3HrI0MRj
0xhV1BWf725FYPP4av0=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
F5KGJgEDQsX2btdjtRUlSmNtuyodIhGXEa3/AXv1Y7qgSO8gknBfiqj5HcIaVA9b4npQpDnNcmq+
1ONAqLeLhdOm9TES+GsTAkh/lClvl89bzfqgOV33iqwQHYIHwSsWMRXT9JSUx+YWu+g6xKpT1Ycn
8BCPsq4QUJIqL6W16fheEHB/lkMgnespIWEYJJG6R6zvv2zG8GiU6cG8zHrRjdvAj8kOkhmiMvSd
YjGXJSMfjw7ojCPSUF+nb6WWhUEmoMA/6lgSVaXRm00YHSZ09k7rKTJWSXFSpTmkL2WOsQhNS0ek
jdTK2KF5K6z2YOK4zkfHgZ+fB0KJyANaLLJH/Q==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
lFuQXeJ0hi7qnIKAR+37XCSOwp8bGLukonngcICceOVpL87+rxvhP5TyNJ/zXpAWDF0BaRYlGr7d
isPiUStrvUthNyOqCr4vFZyhCdY8n+Mrv3OCvLoLQSarxVXbaKbXb0tPsXJCUdXTrCt9mr5x0Nda
6DAI8FBPlFMAiqnFXnYMwlUiSlkNWUpInuNw7+1eD8kUdckEUV1PDwZ0yjpFqMokMH9oJjN6z0Yy
65D8Tqo288ZMfZQuIimjski+X6EK157XbpyuoZIuYLJ7j6oaATdintgfZpgGzVvhCZtMbx6/SJtR
efW5vLBGiGs7rPBPE2T8fosHGOvmeC9QBSj8Ww==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2019_02", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Q8VVvHzTNgU3tZr4+8ia7ylST+kbNPWskONHDOT1dTkB7cHZIAWyzXpQZPuEgk2wJq21PoqmVlG9
t08IYzkfC8vYQ2LRf2Co3SXc7p3gF2OFMC68J9Nf9D+/PXJCJy3QO4H8oO39l6bn8c56K2ARnK0R
mMIALbCWSBDGCWGQmXWZJ+xmDGs1KgTeiSW3bZRftWJ6K8l8BhMit8BLOY2Mi3jJ0WRhN8kKd6JT
D4NU1jTZT6jEtmI7Gnj/AXG6auTqDPHsVQzf+ZzBsLTfw83CFoO70xM997L5cZXlqz8fEDmxezkr
wWxPwJbJeVkRV3tUxlo2Bs2x1uVkXQeNVMI8jg==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
oUeTLA0HA2uKORUHo1HidNC3lw54gxwlLUkv28qRPv1pz7AEVUbIJ7wsyu2Scju+EkC2Ivi8HbBn
jxkeqRDTAwAbAqIKnY3AdyfojN9Hb8SMLcLnpWLLCpb6E0vwA09r7uqKRZ8wYAgT9CPFvzpQ3zKt
9DTLgQ3rZtFxx2nfCug=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Fayrlym1l14Y48yZ195XboT9ZQmp/mAzUyHby3Y9qJTzDF+m6mRQ/ZbebObo8bu4VAm45JeETPx1
YI4UZNOK4IqKv0BZsAlzUfAYAmqmkmIJYbn2gWUCwXyKX5AoA4ONnlxEHxzZhqtsmEXvxwTEs25/
R7iLzeoMfmwwNHgPNQkteiR4zDlB76CYmgu6EOSUX5Nnitq1oh7qRuU8WqWN7lLfgIC6T7qNHwGD
RPze2yiP06fSG45jPrOn2fvBX9SRbUXjNtiFgmqim4anwJU46v7y3ubit/I6giZhz5PJMZfkDaFX
ag+uCMq4Q8ZEolqMBmjUjat86BdVd4Nmr0yUaA==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
kIpxh3qIIkWUg8aLJSPKvKhKTPFH7T8fisti5RtNaftS7xh3KDsGLYnF1lYhH2RVXgzbdaVqvtED
5QJazVo6wUFI91xgFeOR5jX+Ny5UBUX2MngsK+UZyZg5+EdtSiDtiJNtQqgjq1Rn+XQCGF3xP80n
7YvuVMbgRHCAfWrWw7ZJ7Y3raRzeIkx+koPFio7XnC+QdRJ0ItO1YtQgF4Sg1Ihr5TH8/RrNn903
kPa+anH9spo3SFCf2Ts11UXAGLdIBmOLMtEAKjjCUbtmjGSeSc0gn2q2I+xRTFcegLevlr/iuLTw
3lFndBAoW40xOiCDjWZ6Rz7J+jZhsRl3D0Bhwg==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
rLu4xdJ5ZAKctVX04sRMzaf+I4T7aD7kHrhUFr7JeacHp/xJsFZBFE/H+qhK9pEIbgzcoVaW0Ggc
KSlVvUoYpqJ03TJ61JKGb4uEn0DfYrztCLl4yQBI30l6YEqPE3tpzv1delbxaFX36uHN5917ZV36
sLsVpptnhPUjxxxEA0LOibrLLaB9bS1O9pF/+8VvQCaQwUVU+4Q/YABdS2je3/4NfSQsTemD1GMg
WtheqH47O11qWREDwQnj1ElSqfnnV/ooEYyc5Umq4clnMcdMboXdHqFZ0xNQcsOezI/Gvxcw58xL
IRmL1M0l7KC51PmjQvFtC1f8I620eVq4Xs7lrw==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
NUnMCmKBQgsa4S3mUIccVkyDl/puTpc+ZWJ35ihpRjJ+X9gN3t52qOrBowOfgEdPyiHSym4H6CAI
uMUzT7akLpplzueqGIOrUu1vdkvV+03tkaQIME4BZ/uqsOD4p1gJEzREk43uexEdiM4saDdQkRiv
PPA1nRJEU93D9V6C5jKujkfS9oBBNp3yVoCy9k/FIs8tJ7T2gixr+8z3mLax2nDai6XQbX6YHADa
mn3pPJfj+CVqGoc69L06JfPgYzebuaE0gR8pPlSzw+0nXS0YaOUUTHx2QTMVRQ3u/6jm7zYxs0X6
TNlG2bw7x7SLfdW1dw4utgQwKV1NqVqkQdHIqg==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 17232)
`pragma protect data_block
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
6gduv+FEpYzZ2hBHsEqkklTz
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
