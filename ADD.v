module ADD(
    input [31:0]OP,
    output reg[31:0]OPS    
);

always @* begin
    OPS = OP+8'd4;
end


endmodule
