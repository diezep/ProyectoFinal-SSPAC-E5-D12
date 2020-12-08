module UC(
	input [5:0]inscod,
	output reg RegDist,
	output reg Branch,
	output reg MemRead,
	output reg Memtoreg,
	output reg [3:0]ALUop,
	output reg MemWrite,
	output reg ALUsrc,
	output reg Regwrite,
	output reg jump
);
//Definimos los reg y wires

always@*
begin
	case(inscod) 
	 6'b000000:		//R Instruction 
		begin
			RegDist=1;
			Regwrite=1;
			MemWrite=0;
			Memtoreg=0;
			ALUsrc=0;
			Branch=0;
			MemRead=0;
			ALUop=4'b0111;
			jump=0;
		end
	
	6'b001000:		//Addi
		begin
			RegDist=0;
			Regwrite=1;
			MemWrite=0;
			Memtoreg=0;
			ALUsrc=1;
			Branch=0;
			MemRead=0;
			ALUop=4'b0001;
			jump=0;	
		end

	6'b001100:		//Andi
		begin
			RegDist=0;
			Regwrite=1;
			MemWrite=0;
			Memtoreg=0;
			ALUsrc=1;
			Branch=0;
			MemRead=0;
			ALUop=4'b0000;
			jump=0;	
		end

	6'b001101:		//Ori
		begin
			RegDist=0;
			Regwrite=1;
			MemWrite=0;
			Memtoreg=0;
			ALUsrc=1;
			Branch=0;
			MemRead=0;
			ALUop=4'b0010;
			jump=0;	
		end	
	6'b001010:		//slti
		begin
			RegDist=0;
			Regwrite=1;
			MemWrite=0;
			Memtoreg=0;
			ALUsrc=1;
			Branch=0;
			MemRead=0;
			ALUop=4'b0011;
			jump=0;	
		end	
	6'b000100:		//Branch on equal
		begin
			RegDist=0;
			Regwrite=0;
			MemWrite=0;
			Memtoreg=0;
			ALUsrc=0;
			Branch=1;
			MemRead=0;
			ALUop=4'b0101;
			jump=0;	
		end	
	6'b000101:		//Branch non equal
		begin
			RegDist=0;
			Regwrite=0;
			MemWrite=0;
			Memtoreg=0;
			ALUsrc=0;
			Branch=1;
			MemRead=0;
			ALUop=4'b0110;
			jump=0;	
		end	
	6'b100011:		//Load word
		begin
			RegDist=0;
			Regwrite=1;
			MemWrite=0;
			Memtoreg=1;
			ALUsrc=1;
			Branch=1;
			MemRead=1;
			ALUop=4'b1000;
			jump=0;	
		end	
	6'b101011:		//Save word
		begin
			RegDist=0;
			Regwrite=0;
			MemWrite=1;
			Memtoreg=0;
			ALUsrc=1;
			Branch=0;
			MemRead=0;
			ALUop=4'b0100;
			jump=0;	
		end
	6'b000010:  //jump
		begin
			RegDist=0;
			Regwrite=0;
			MemWrite=0;
			Memtoreg=0;
			ALUsrc=0;
			Branch=0;
			MemRead=0;
			ALUop=4'b0110;
			jump=1;
		end
	6'b000111:    //bgtz
		begin
			RegDist=0;
			Regwrite=0;
			MemWrite=0;
			Memtoreg=0;
			ALUsrc=0;
			Branch=1;
			MemRead=0;
			ALUop=4'b1001;
			jump=0;
		end

	endcase
end
endmodule
