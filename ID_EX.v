module ID_EX (
    input clk,
    input iRegWrite,
    input iMemToReg,
    input iMemWrite,
    input iMemRead,
    input iBranch,
    input [3:0] iAluOP,
    input iALUSrc,
    input iRegDst,
    input ijump,
    input [31:0] iAddPC,
    input [31:0] iData1,
    input [31:0] iData2,
    input [31:0] iSignExtend,
    input [4:0] iInstr2016,
    input [4:0] iInstr1511,
    output reg oRegWrite,
    output reg oMemToReg,
    output reg oMemWrite,
    output reg oMemRead,
    output reg oMemBranch,
    output reg [3:0] oAluOP,
    output reg oALUSrc,
    output reg oRegDst,
    output reg ojump,
    output reg [31:0] oAddPC,
    output reg [31:0] oData1,
    output reg [31:0] oData2,
    output reg [31:0] oSignExtend,
    output reg [4:0] oInstr2016,
    output reg [4:0] oInstr1511
);

always @(posedge clk) 
begin
    oRegWrite <= iRegWrite;
    oMemToReg <= iMemToReg;
    oMemWrite <= iMemWrite;
    oMemRead  <= iMemRead;
    oMemBranch <= iBranch;
    oAluOP <= iAluOP;
    oALUSrc <= iALUSrc;
    ojump <= ijump;
    oRegDst <= iRegDst;
    oAddPC <= iAddPC;
    oData1 <= iData1;
    oData2 <= iData2;
    oSignExtend <= iSignExtend;
    oInstr2016 <= iInstr2016;
    oInstr1511 <= iInstr1511;
end

endmodule
