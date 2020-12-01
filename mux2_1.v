module MUX2_1 (
    input[31:0] SELOP,
    input[31:0] OP0,
    input[31:0] OP1,
    output[31:0] OPS
);

always @(*) begin
  if(SELOP)
    OPS<=OP1;
  else
    OPS<=OP0;
end
    
endmodule