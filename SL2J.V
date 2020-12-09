module SL2J(
 input [25:0]datain,
 output reg [27:0]dataout
);
//reg y wire

always @*
begin
 dataout=datain<<2;
end

endmodule