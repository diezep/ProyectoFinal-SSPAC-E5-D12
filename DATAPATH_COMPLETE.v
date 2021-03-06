module DATAPATH_COMPLETE(
    input clk
);


wire [31:0] PCtoINSTMEManADDER;
wire [31:0] INSTMEM_instruction;
wire UCtoBR_regWrite;
wire UCtoMUX_regDist;
wire [4:0] MUXtoBR_OPS;
wire [3:0] UCtoALUC_aluOp;
wire UCtoMUX_ALUsrc;
wire [31:0] BRtoMUX_dr2;
wire [31:0] SIGNEXTENDtoMUXandSF_ex32;
wire [31:0] BRtoALU_OP1;
wire [31:0] MUXtoALU_OP2;
wire [3:0] ALUCtoALU_ALUOP;
wire UCtoMEM_MEMREAD;
wire [31:0]ALUtoMEM_OPSDIR;
wire [31:0]MEMtoMUX2_1READATA;
wire [31:0]MUX2_1toBR_DIN;
wire B3toMEM_MEMWRITE;
wire CAND1;
wire CAND2;
wire UCtoMUX2_1_BRANCH;
wire [31:0]MUXtoPC_IN;
wire [31:0]ADDtoMUX2_1_OUT;
wire [31:0]ADD_SLtoMux2_1;
wire [31:0]SHIFTLEFTtoADDER_adder;
wire [31:0]ADDSL2toMUXPC;
wire [27:0]SL2J_OUT;
wire [31:0]SL2JtoMUX32;
wire [31:28]ADDERtoJUMP;
wire SelectJUMPMUX;
wire [31:0]MUXJUMPtoPC;
wire [31:0]MUXtoMUXjump;
wire [31:0]ADDER_IN_BUFFER1;
wire [31:0]ADDER_OUT_BUFFER1;
wire [31:0]INSTRUCCION_OUT_BUFFER1;
wire REGWRITE_IN_BUFFER2;
wire MEMWRITE_IN_BUFFER2;
wire MEMREAD_IN_BUFFER2;
wire BRANCH_IN_BUFFER2;
wire ALUSRC_IN_BUFFER2;
wire REGDST_IN_BUFFER2;
wire JUMP_IN_BUFFER2;
wire REGWRITE_IN_BUFFER3;
wire REGWRITE_IN_BUFFER4;
wire MEMWRITE_IN_BUFFER3;
wire MEMREAD_IN_BUFFER3;
wire BRANCH_IN_BUFFER3;
wire JUMP_IN_BUFFER3;
wire [3:0]ALUOP_IN_BUFFER2;
wire [31:0]ADDER_IN_BUFFER2;
wire [31:0]DATA1_IN_BUFFER2;
wire [31:0]DATA2_IN_BUFFER2;
wire [31:0]SIGNEXTEND_OUT_BUFFER2;
wire [31:0]ADDER_IN_ADDERSL2;
wire [31:0]SignextendToALL;
wire [31:0]RESULTMEM_TO_BUFFER4;
wire [31:0]BRtoMUX_dr2_OUT_BUFFER2;
wire [31:0]ALURESULTtoBuffer4;
wire [31:0]ADDSL2toMUXPCtoBUFFER3;
wire [31:0]ALURESULTtoBUFFER3;
wire [4:0]INSTR2016TOMUX;
wire [4:0]INSTR1511TOMUX;
wire [4:0]MUXRDSTRESULTtoBUFFER3;
wire [4:0]MUXRDSTRESULTtoBUFFER4;
wire ZEROFLAGtoBUFFER3;
wire UCtoB2MemtoReg;
wire B2toB3MemtoReg;
wire B3toB4MemtoReg;
wire B4toMUXMemtoReg;
wire B2toB3_MemWrite;
wire [25:0]JumpInstructionWire;
wire [27:0]JumpInstrucSL2;
wire ultimatejump;


assign SL2JtoMUX32 = {ADDER_IN_ADDERSL2[31:28],SL2J_OUT};
assign UCtoMUX2_1_BRANCH = CAND1&CAND2; 

MUX2_1 MUXtoPC(
    .SELOP(UCtoMUX2_1_BRANCH),
    .OP0(ADDER_IN_BUFFER1),
    .OP1(ADDSL2toMUXPC),
    .OPS(MUXtoMUXjump)    
);

MUX2_1 MUXJUMP(
    .SELOP(ultimatejump),
    .OP0(MUXtoMUXjump),
    .OP1(SL2JtoMUX32),
    .OPS(MUXtoPC_IN)
);

PC pc(
    .clk(clk),
    .pc(MUXtoPC_IN),
    .opc(PCtoINSTMEManADDER)
);

INSTMEM intructionMemory(
    .readA(PCtoINSTMEManADDER),
    .instruction(INSTMEM_instruction)
);

ADD pctoMuxAdder(
    .OP(PCtoINSTMEManADDER),
    .OPS(ADDER_IN_BUFFER1)
);  

IF_ID buffer1(
    .clk(clk),
    .inst_in(INSTMEM_instruction),
    .adderin(ADDER_IN_BUFFER1),
    .inst_out(INSTRUCCION_OUT_BUFFER1),
    .adderout(ADDER_OUT_BUFFER1)
);

UC unidadControl(
    .inscod(INSTRUCCION_OUT_BUFFER1[31:26]),
	.RegDist(REGDST_IN_BUFFER2),
	.Branch(BRANCH_IN_BUFFER2),
	.MemRead(MEMREAD_IN_BUFFER),
	.Memtoreg(UCtoB2MemtoReg),
	.ALUop(ALUOP_IN_BUFFER2),
	.MemWrite(MEMWRITE_IN_BUFFER2),
	.ALUsrc(ALUSRC_IN_BUFFER2),
	.Regwrite(REGWRITE_IN_BUFFER2),
    .jump(JUMP_IN_BUFFER2)
);

BR bancoRegistros(
    .din(MUX2_1toBR_DIN), 
    .ra1(INSTRUCCION_OUT_BUFFER1[25:21]),
    .ra2(INSTRUCCION_OUT_BUFFER1[20:16]),
    .wa(MUXtoBR_OPS),
    .rw(UCtoBR_regWrite),
    .dr1(DATA1_IN_BUFFER2),
    .dr2(DATA2_IN_BUFFER2)
);

SIGNEXTEND signExtend(
    .ex16(INSTRUCCION_OUT_BUFFER1[15:0]),
    .ex32(SIGNEXTEND_OUT_BUFFER2)
);

ID_EX buffer2(
    .clk(clk),
    .iRegWrite(REGWRITE_IN_BUFFER2),
    .iMemToReg(UCtoB2MemtoReg),
    .iMemWrite(MEMWRITE_IN_BUFFER2),
    .iMemRead(MEMREAD_IN_BUFFER),
    .iBranch(BRANCH_IN_BUFFER2),
    .iAluOP(ALUOP_IN_BUFFER2),
    .iALUSrc(ALUSRC_IN_BUFFER2),
    .iRegDst(REGDST_IN_BUFFER2),
    .ijump(JUMP_IN_BUFFER2),
    .iAddPC(ADDER_OUT_BUFFER1),
    .iData1(DATA1_IN_BUFFER2),
    .iData2(DATA2_IN_BUFFER2),
    .iSignExtend(SIGNEXTEND_OUT_BUFFER2),
    .iInstr2016(INSTRUCCION_OUT_BUFFER1[20:16]),
    .iInstr1511(INSTRUCCION_OUT_BUFFER1[15:11]),
    .oRegWrite(REGWRITE_IN_BUFFER3),
    .oMemToReg(B2toB3MemtoReg),
    .oMemWrite(B2toB3_MemWrite),
    .oMemRead(MEMREAD_IN_BUFFER3),
    .oMemBranch(BRANCH_IN_BUFFER3),
    .oAluOP(UCtoALUC_aluOp),
    .oALUSrc(UCtoMUX_ALUsrc),
    .oRegDst(UCtoMUX_regDist),
    .ojump(JUMP_IN_BUFFER3),
    .oAddPC(ADDER_IN_ADDERSL2),
    .oData1(BRtoALU_OP1),
    .oData2(BRtoMUX_dr2_OUT_BUFFER2),
    .oSignExtend(SignextendToALL),
    .oInstr2016(INSTR2016TOMUX),
    .oInstr1511(INSTR1511TOMUX),
    .inputJumpInstr1(INSTRUCCION_OUT_BUFFER1[25:0]),
    .salidaJumpInstr1(JumpInstructionWire)
);

MUX2_1 muxBRandSIGNEXTENDtoALU_OP2(
    .SELOP(UCtoMUX_ALUsrc),
    .OP0(BRtoMUX_dr2_OUT_BUFFER2),
    .OP1(SignextendToALL),
    .OPS(MUXtoALU_OP2)
);

SL2 shiftLeft(
  .datain(SignextendToALL),
  .dataout(SHIFTLEFTtoADDER_adder)
);

muxrdst MUXtoBR(
    .SEL_RDST(UCtoMUX_regDist),
    .OP0(INSTR2016TOMUX),
    .OP1(INSTR1511TOMUX),
    .OPS(MUXRDSTRESULTtoBUFFER3)
);


SL2 shiftLeft_(
  .datain(SignextendToALL),
  .dataout(SHIFTLEFTtoADDER_adder)
);

SL2J SHIFTJUMP(
    .datain(JumpInstructionWire),
    .dataout(SL2J_OUT)
);

ALUC aluControl(
    .func(SignextendToALL[5:0]),
    .UC_aluOp(UCtoALUC_aluOp),
    .ALU_aluOp(ALUCtoALU_ALUOP)
);


ALU alu(
    .OP1(BRtoALU_OP1),
	.OP2(MUXtoALU_OP2),
	.OP(ALUCtoALU_ALUOP),
	.OPS(ALURESULTtoBUFFER3),
	.ZF(ZEROFLAGtoBUFFER3)
);

addsl2 AdderSL2(
    .OP(ADDER_IN_ADDERSL2),
    .OP1(SHIFTLEFTtoADDER_adder),
    .OPS(ADDSL2toMUXPCtoBUFFER3)
);

EX_MEM buffer3(
    .clk(clk),    
    .iRegWrite(REGWRITE_IN_BUFFER3),
    .iMemToReg(B2toB3MemtoReg),
    .iMemWrite(B2toB3_MemWrite),
    .iMemRead(MEMREAD_IN_BUFFER3),
    .iMemBranch(BRANCH_IN_BUFFER3),
    .ijump(JUMP_IN_BUFFER3),  
    .iAdderSL2Result(ADDSL2toMUXPCtoBUFFER3),  
    .iZFlag(ZEROFLAGtoBUFFER3),  
    .iAluRes(ALURESULTtoBUFFER3),  
    .iData2(BRtoMUX_dr2_OUT_BUFFER2),  
    .iRegDestMux(MUXRDSTRESULTtoBUFFER3),  
    .oRegWrite(REGWRITE_IN_BUFFER4),
    .oMemToReg(B3toB4MemtoReg),
    .oMemWrite(B3toMEM_MEMWRITE),
    .oMemRead(UCtoMEM_MEMREAD),
    .oMemBranch(CAND1),
    .ojump(SelectJUMPMUX),  
    .oAdderSL2Result(ADDSL2toMUXPC),  
    .oZFlag(CAND2),  
    .oAluRes(ALUtoMEM_OPSDIR),  
    .oData2(BRtoMUX_dr2),  
    .oRegDestMux(MUXRDSTRESULTtoBUFFER4)    
);

MEM MEMDATA(
    .dati(BRtoMUX_dr2),
    .memwrite(B3toMEM_MEMWRITE),
    .memread(UCtoMEM_MEMREAD),
    .dir(ALUtoMEM_OPSDIR),
    .dato(RESULTMEM_TO_BUFFER4)
);


MEM_WB buffer4(
    .clk(clk),
    .iRegWrite(REGWRITE_IN_BUFFER4),
    .iMemToReg(B3toB4MemtoReg),
    .iMemRes(RESULTMEM_TO_BUFFER4),
    .ijump(SelectJUMPMUX),
    .iAluRes(ALUtoMEM_OPSDIR),
    .iWriteRegister(MUXRDSTRESULTtoBUFFER4),
    .oRegWrite(UCtoBR_regWrite),
    .oMemToReg(B4toMUXMemtoReg),
    .oMemRes(MEMtoMUX2_1READATA),
    .oAluRes(ALURESULTtoBuffer4),
    .oWriteRegister(MUXtoBR_OPS),
    .ojump(ultimatejump)
);

MUX2_1 muxALURESULTtoDIRtoMUX(
    .SELOP(B4toMUXMemtoReg),
    .OP0(ALURESULTtoBuffer4),
    .OP1(MEMtoMUX2_1READATA),
    .OPS(MUX2_1toBR_DIN)
);

endmodule