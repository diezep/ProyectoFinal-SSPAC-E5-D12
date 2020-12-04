module ADD(
    input [31:0] OP,
    input [31:0] ADDER,
    output [31:0] OPS    
);

always @(*) begin
    OPS = OP + ADDER;
end

endmodule