module ALU(
	input[31:0] OP1,
	input[31:0] OP2,
	input[3:0] OP,
	output reg[31:0] OPS,
	output reg ZF
);

always @*
begin

	case(OP)
		4'b0000:
			OPS = OP1 & OP2;
		4'b0001:
			OPS = OP1 | OP2;
		4'b0010:
			OPS = OP1 + OP2;
		4'b0011:
			OPS = OP1 - OP2;	
		4'b0100:
			OPS = OP1 < OP2 ? 1 : 0;
		4'b0101:
			OPS = OP1 / OP2;
		4'b0110:
			OPS = 32'd0;
		4'b0111:
			OPS = OP1 * OP2;
		4'b1111:
			OPS = OP1 ^ OP2;
	endcase

	if(OPS==0)
		ZF = 1;
	else 
		ZF = 0;
end
endmodule
