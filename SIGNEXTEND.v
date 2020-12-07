module SIGNEXTEND(
    input[15:0] ex16,
    output reg[31:0] ex32
);

always@*
begin
    assign ex32 = {{16{ex16[15]}}, ex16};
end
endmodule 
