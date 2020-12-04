
module SL2(
 input [31:0]datain,
 output reg [31:0]dataout
);
//reg y wire

always @*
begin
 dataout=datain<<2;
end

endmodule
