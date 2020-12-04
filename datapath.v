module Datapath(
    input clk,
    output[31:0] result
);


wire [31:0] PCtoINSTMEM;
wire [31:0] INSTMEM_instruction;
wire UCtoBR_regWrite;
wire UCtoMUX_regDist;
wire [4:0] MUXtoBR_OPS;
wire [2:0] UCtoALUC_aluOp;
wire UCtoMUX_ALUsrc;
wire [31:0] BRtoMUX_dr2;
wire [31:0] SIGNEXTENDtoMUX_ex32;
wire [31:0] BRtoALU_OP1;
wire [31:0] MUXtoALU_OP2;

PC pc(
    .clk(clk),
    .pc(),
    .opc(PCtoINSTMEM)
)

INSTMEM intructionMemory(
    .readA(PCtoINSTMEM),
    .instruction(INSTMEM_instruction)
);

UC unidadControl(
    .inscod(INSTMEM_instruction[31:26]),
	.RegDist(UCtoMUX_regDist),
	.Branch(),
	.MemRead(),
	.Memtoreg(),
	.ALUop(UCtoALUC_aluOp),
	.MemWrite(),
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
    // .din(INSTMEM_instruction[25:21]), 
    .ra1(INSTMEM_instruction[25:21]),
    .ra2(INSTMEM_instruction[20:16]),
    .wa(MUXtoBR_OPS),
    .rw(UCtoBR_regWrite),
    .dr1(BRtoALU_OP1),
    .dr2(BRtoMUX_dr2)
);

SIGNEXTEND signExtend(
    .ex16(INSTMEM_instruction[15:0]),
    .ex32(SIGNEXTENDtoMUX_ex32)
);

ALUC aluControl(
    .func(INSTMEM_instruction[5:0]),
    .UC_aluOp(UCtoALUC_aluOp),
    .ALU_aluOp()
);

MUX2_1 muxBRandSIGNEXTENDtoALU_OP2(
    .SELOP(UCtoMUX_ALUsrc),
    .OP0(BRtoMUX_dr2),
    .OP1(SIGNEXTENDtoMUX_ex32),
    .OPS(MUXtoALU_OP2)
);

ALU alu(
    .OP1(BRtoALU_OP1),
	.OP2(MUXtoALU_OP2),
	.OP(),
	.OPS(),
	.ZF()
);

endmodule