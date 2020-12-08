module MEM_WB( 
    input clk,
    input iRegWrite,
    input iMemToReg,
    input [31:0] iMemRes,
    input [31:0] iAluRes,
    input [4:0] iWriteRegister,
    output reg oRegWrite,
    output reg oMemToReg,
    output reg [31:0] oMemRes,
    output reg [31:0] oAluRes,
    output reg [4:0] oWriteRegister
);

always @(posedge clk ) 
begin
    oRegWrite <= iRegWrite;
    oMemToReg <= iMemToReg;
    oMemRes <= iMemRes;
    oAluRes <= iAluRes;
    oWriteRegister <= iWriteRegister;
end
endmodule
