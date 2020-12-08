module IF_ID(
    input clk,
    input [31:0]inst_in,
    output reg [31:0]inst_out,
    input [31:0]adderin,
    output reg [31:0]adderout
);

always @(posedge clk) 
begin
    inst_out <= inst_in;
    adderout <= adderin;
end

endmodule