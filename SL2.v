
module SL2(
input [32:0]datain,
output reg [32:0]dataout
);
//reg y wire

always @*
begin
 dataout=datain<<2;
end

endmodule
