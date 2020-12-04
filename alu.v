`timescale 1ns/1ns

module ALU(
	input[31:0] OP1,
	input[31:0] OP2,
	input[2:0] OP,
	output reg[31:0] OPS,
	output reg ZF
);

always @(*)
begin

	case(OP)
		3'b000:
			assign OPS = OP1 & OP2;
		
		3'b001:
			assign OPS = OP1 | OP2;
		
		3'b010:
			assign OPS = OP1 + OP2;
		
		3'b011:
			assign OPS = OP1 - OP2;	
		
		3'b100:
			assign OPS = OP1 < OP2 ? 1 : 0;
			
		3'b101:
			assign OPS = OP1 / OP2;
		
		3'b110:
			assign OPS = 32'd0;
		
		3'b111:
			assign OPS = OP1 * OP2;
	endcase

	if(OPS==0)
		ZF <= 1;
	else 
		ZF <= 0;
end
endmodule
