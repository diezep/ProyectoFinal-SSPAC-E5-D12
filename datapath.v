module DATAPATH(
    input clk,
    output[31:0] result
);


wire [31:0] PCtoINSTMEManADDER;
wire [31:0] INSTMEM_instruction;
wire UCtoBR_regWrite;
wire UCtoMUX_regDist;
wire [4:0] MUXtoBR_OPS;
wire [2:0] UCtoALUC_aluOp;
wire UCtoMUX_ALUsrc;
wire [31:0] BRtoMUX_dr2;
wire [31:0] SIGNEXTENDtoMUXandSF_ex32;
wire [31:0] BRtoALU_OP1;
wire [31:0] MUXtoALU_OP2;
wire [2:0] ALUCtoALU_ALUOP;
wire UCtoMEM_MEMREAD;
wire [31:0]ALUtoMEM_OPSDIR;
wire UCtoMUX2_1MEMTOREG;
wire [31:0]MEMtoMUX2_1READATA;
wire [31:0]MUX2_1toBR_DIN;
wire UCtoMEM_MEMWRITE;
wire CAND1;
wire CAND2;
wire UCtoMUX2_1_BRANCH;
wire [31:0]MUXtoPC_IN;
wire [31:0]ADDtoMUX2_1_OUT;
wire [31:0]ADD_SLtoMux2_1;
wire [31:0] SHIFTLEFTtoADDER_adder;

assign UCtoMUX2_1_BRANCH = CAND1&CAND2; 

PC pc(
    .clk(clk),
    .pc(MUXtoPC_IN),
    .opc(PCtoINSTMEManADDER)
);

INSTMEM intructionMemory(
    .readA(PCtoINSTMEManADDER),
    .instruction(INSTMEM_instruction)
);

UC unidadControl(
    .inscod(INSTMEM_instruction[31:26]),
	.RegDist(UCtoMUX_regDist),
	.Branch(CAND1),
	.MemRead(UCtoMEM_MEMREAD),
	.Memtoreg(UCtoMUX2_1MEMTOREG),
	.ALUop(UCtoALUC_aluOp),
	.MemWrite(UCtoMEM_MEMWRITE),
	.ALUsrc(UCtoMUX_ALUsrc),
	.Regwrite(UCtoBR_regWrite)
);

MUX2_1 muxINSTMEMtoBR(
    .SELOP(UCtoMUX_regDist),
    .OP0(INSTMEM_instruction[20:16]),
    .OP1(INSTMEM_instruction[15:11]),
    .OPS(MUXtoBR_OPS)
);

BR bancoRegistros(
    .din(MUX2_1toBR_DIN), 
    .ra1(INSTMEM_instruction[25:21]),
    .ra2(INSTMEM_instruction[20:16]),
    .wa(MUXtoBR_OPS),
    .rw(UCtoBR_regWrite),
    .dr1(BRtoALU_OP1),
    .dr2(BRtoMUX_dr2)
);

SIGNEXTEND signExtend(
    .ex16(INSTMEM_instruction[15:0]),
    .ex32(SIGNEXTENDtoMUXandSF_ex32)
);

ALUC aluControl(
    .func(INSTMEM_instruction[5:0]),
    .UC_aluOp(UCtoALUC_aluOp),
    .ALU_aluOp(ALUCtoALU_ALUOP)
);

MUX2_1 muxBRandSIGNEXTENDtoALU_OP2(
    .SELOP(UCtoMUX_ALUsrc),
    .OP0(BRtoMUX_dr2),
    .OP1(SIGNEXTENDtoMUXandSF_ex32),
    .OPS(MUXtoALU_OP2)
);
MUX2_1 muxALURESULTtoDIRtoMUX(
    .SELOP(UCtoMUX2_1MEMTOREG),
    .OP0(ALUtoMEM_OPSDIR),
    .OP1(MEMtoMUX2_1READATA),
    .OPS(MUX2_1toBR_DIN)
);

MUX2_1 MUX_CICLO_FETCH(
    .SELOP(UCtoMUX2_1_BRANCH),
    .OP0(ADDtoMUX2_1_OUT),
    .OP1(ADD_SLtoMux2_1),
    .OPS(MUXtoPC_IN)
);

ALU alu(
    .OP1(BRtoALU_OP1),
	.OP2(MUXtoALU_OP2),
	.OP(ALUCtoALU_ALUOP),
	.OPS(ALUtoMEM_OPSDIR),
	.ZF(CAND2)
);

MEM MEMDATA(
    .dati(MUX2_1toBR_DIN),
    .memwrite(UCtoMEM_MEMWRITE),
    .memread(UCtoMEM_MEMREAD),
    .dir(ALUtoMEM_OPSDIR),
    .dato(MEMtoMUX2_1READATA)
);

ADD pctoMuxAdder(
    .OP(PCtoINSTMEManADDER),
    .ADDER(4),
    .OPS(ADDtoMUX2_1_OUT)    
);
ADD MUXtoPC(
    .OP(ADDtoMUX2_1_OUT),
    .ADDER(SHIFTLEFTtoADDER_adder),
    .OPS(ADD_SLtoMux2_1)    
);

SL2 shiftLeft(
  .datain(SIGNEXTENDtoMUXandSF_ex32),
  .dataout(SHIFTLEFTtoADDER_adder)
);

endmodule
