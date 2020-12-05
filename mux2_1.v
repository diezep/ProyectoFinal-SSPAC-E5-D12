module MUX2_1(
    input SELOP,
    input [31:0]OP0,
    input [31:0]OP1,
    output reg [31:0]OPS
);

always @* 
begin
  if(SELOP)
    OPS<=OP1;
  else
    OPS<=OP0;
end
endmodule
