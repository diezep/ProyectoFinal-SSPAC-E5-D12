module EX_MEM(
    input clk,    
    input iRegWrite,
    input iMemToReg,
    input iMemWrite,
    input iMemRead,
    input iMemBranch,
    input ijump,  
    input [31:0] iAdderSL2Result,  
    input iZFlag,  
    input [31:0] iAluRes,  
    input [31:0] iData2,  
    input [4:0] iRegDestMux,  
    output reg oRegWrite,
    output reg oMemToReg,
    output reg oMemWrite,
    output reg oMemRead,
    output reg oMemBranch,
    output reg ojump,  
    output reg [31:0] oAdderSL2Result,  
    output reg oZFlag,  
    output reg [31:0] oAluRes,  
    output reg [31:0] oData2,  
    output reg [4:0] oRegDestMux
);
always @(posedge clk ) 
begin
    oRegWrite <= iRegWrite;
    oMemToReg <= iMemToReg;
    oMemWrite <= iMemWrite;
    oMemRead <= iMemRead;
    oMemBranch <= iMemBranch;
    ojump <= ijump;  
    oAdderSL2Result <= iAdderSL2Result;  
    oZFlag <= iZFlag;  
    oAluRes <= iAluRes;  
    oData2 <= iData2;  
    oRegDestMux <= iRegDestMux;  
end
endmodule
