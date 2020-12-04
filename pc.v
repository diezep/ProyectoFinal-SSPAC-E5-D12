module PC(
    input clk,
    input [31:0] pc,
    output reg [31:0] opc 
);


reg [31:0] value = 8'd0;

initial
begin
  opc = 0;
end

always @(pc) begin
    value=pc;
end

always @(posedge clk) begin
    opc = value;
end
endmodule