module EX_MEM(
    input clk,    
    input iRegWrite,
    input iMemToReg,
    input iMemWrite,
    input iMemRead,
    input iMemBranch,  
    input [31:0] iBranchResult,  
    input iZFlag,  
    input [31:0] iAluRes,  
    input [31:0] iData2,  
    input [4:0] iRegDestMux,  
    output reg oRegWrite,
    output reg oMemToReg,
    output reg oMemWrite,
    output reg oMemRead,
    output reg oMemBranch,  
    output reg [31:0] oBranchResult,  
    output reg oZFlag,  
    output reg [31:0] oAluRes,  
    output reg [31:0] oData2,  
    output reg [4:0] oRegDestMux
);
always @(posedge clk ) begin
    oRegWrite           <=iRegWrite;
    oMemToReg           <=iMemToReg;
    oMemWrite           <=iMemWrite;
    oMemRead            <=iMemRead;
    oMemBranch          <=iMemBranch;  
    oBranchResult       <=iBranchResult;  
    oZFlag              <=iZFlag;  
    oAluRes             <=iAluRes;  
    oData2              <=iData2;  
    oRegDestMux         <=iRegDestMux;  
end
endmodule