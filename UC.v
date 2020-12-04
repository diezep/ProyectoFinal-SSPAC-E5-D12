
module UC(
	input [5:0]inscod,
	output reg RegDist,
	output reg Branch,
	output reg MemRead,
	output reg Memtoreg,
	output reg [2:0]ALUop,
	output reg MemWrite,
	output reg ALUsrc,
	output reg Regwrite
);
//Definimos los reg y wires

always@*
begin
	case(inscod) 
	 6'b000000: 
		begin
			RegDist=1;
			Regwrite=1;
			MemWrite=0;
			Memtoreg=0;
			ALUsrc=0;
			Branch=0;
			MemRead=0;
			ALUop=3'b111;
		end
	endcase
end
endmodule
