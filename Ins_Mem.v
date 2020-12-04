module Ins_Mem(
input[31:0]readA,
output reg [31:0]instruction

);

reg [7:0]Imem[0:127];

always@*
	begin
		instruction={Imem[readA],Imem[readA+1],Imem[readA+2],Imem[readA+3]};
	end
	
endmodule
