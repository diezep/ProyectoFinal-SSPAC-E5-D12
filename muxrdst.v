module muxrdst(
    input SEL_RDST,
    input [4:0]OP0,
    input [4:0]OP1,
    output reg [4:0]OPS
);

always@*
	begin
		if(SEL_RDST==0)
			OPS=OP0;
		else
			OPS=OP1;
	end

endmodule