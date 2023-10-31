    `define IMM26BITS     25:0
    `define IMM16BITS     15:0
    `define OpCodeBITS    31:26
    `define FunctBITS     5:0
    `define RsBITS		  25:21
	`define RtBITS		  20:16
	`define RdBITS	      15:11
	`define ShamtBITS	  10:6

    `define InstrsUseRs   addi||addiu||add||addu||sub ||subu||lw  ||sw  ||lb   ||\
                          lbu ||lh ||lhu ||sb  ||sh   ||jr  ||jalr||mult||multu||\
                          div||divu||mthi||mtlo||sllv ||srlv||srav||And ||Or   ||\
                          Xor ||Nor||ori||Andi||Xori||slt||sltu||slti||sltiu||  \
				          beq ||bne ||blez||bgtz||bltz||bgez|| mul

    `define InstrsUseRt   add ||addu||sub||subu||sw||sb||sh||mult||multu||div||\
                          divu||sll||srl||sra||sllv||srlv||srav||And||Or||Xor||\
                          Nor||slt||sltu||beq||bne||mtc0||mul

    `define OutForRs      (beq||bne||blez||bgtz||bltz||bgez)||slti ? 0:(addi||\
                           addiu||add||addu||sub||subu||lw||sw||lb||lbu||lh ||\
                           lhu||sb||sh||mult||multu||div||mthi||mtlo||divu  ||\
                           sllv||srlv||srav||And||Or||Xor||Nor||ori||Andi   ||\
                           Xori||slt||sltu||sltiu||mul)?1:0
                        
    `define OutForRt      (beq||bne)?0:(add||addu||sub||subu||mult||multu   ||\
                           div||divu||sll||srl||sra||sllv||srlv||srav||And  ||\
                           Or||Xor||Nor||slt||sltu||mul)?1:(sw||sb||sh||mtc0)?2:0

    `define OutForNew     (lw||lhu||lh||lbu||lb||mfc0)||slti?3:(addi||addiu ||\
                           add||addu||sub||subu||lui||jal||jalr||mfhi||mflo ||\
                           sll||srl||sra||sllv||srlv||srav||And||Or||Xor    ||\
                           Nor||ori||Andi||Xori||slt||sltu||sltiu||mul)?2:3

    `define MCycleInstrs  mult|multu|div|divu|mfhi|mflo|mthi|mtlo

    `define DecodeForWE   addi||addiu||add||addu||sub||subu||ori||lui||Or||And||\
                            Xor||Nor||Andi||Xori||lw||lh||lhu||lb||lbu||jal||jalr||\
							mfhi||mflo||sll||srl||sra||sllv||srlv||srav||\
							slt||slti||sltu||sltiu||mfc0||mfhi||mflo||mul

    `define DecodeForReg  (addi||addiu||ori||Xori||Andi||lui||lw||lhu||lh||\
                           lbu||lb||slti||sltiu||mfc0)?Rt:(add||addu||sub||\
                           subu||mfhi||mflo||sll||srl||sra||sllv||srlv||srav||\
                           slt||sltu||And||Or||Xor||Nor||jalr||mul)?Rd:(jal)?5'd31:Rd

    `define InstrBusWidth 54:0

    `define InstrBusWireSet lb,lbu,lh,lhu,lw,sb,sh,sw,addi,addiu,add,addu,sub,subu,\
                            lui,ori,And,Or,Xor,Nor,Andi,Xori,beq,bne,blez,bgtz,bltz,bgez,\
                            j,jal,jr,jalr,nop,mult,multu,div,divu,mfhi,mthi,mflo,mtlo,\
                            sll,srl,sra,sllv,srlv,srav,slt,slti,sltu,sltiu,mfc0,mtc0,eret,mul

    `define ClkFrequency 65000000

    `define Baud 9600
