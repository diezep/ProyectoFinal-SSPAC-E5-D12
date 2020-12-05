module ALU(
	input[31:0] OP1,
	input[31:0] OP2,
	input[2:0] OP,
	output reg[31:0] OPS,
	output reg ZF
);

always @*
begin

	case(OP)
		3'b000:
			OPS = OP1 & OP2;
		3'b001:
			OPS = OP1 | OP2;
		3'b010:
			OPS = OP1 + OP2;
		3'b011:
			OPS = OP1 - OP2;	
		3'b100:
			OPS = OP1 < OP2 ? 1 : 0;
		3'b101:
			OPS = OP1 / OP2;
		3'b110:
			OPS = 32'd0;
		3'b111:
			OPS = OP1 * OP2;
	endcase

	if(OPS==0)
		ZF = 1;
	else 
		ZF = 0;
end
endmodule
