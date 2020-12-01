module ALU(
	input[15:0] i_op1,
	input[15:0] i_op2,
	input[1:0] Selector_de_Operacion,
	output reg[31:0] R_DeOpSeleccionada 
);

always @*
begin
case(Selector_de_Operacion)
	2'd1:
		assign R_DeOpSeleccionada = i_op1 + i_op2;
	
	2'd2:
		assign R_DeOpSeleccionada = i_op1 - i_op2;
	
	2'd3:
		assign R_DeOpSeleccionada = i_op1 * i_op2;
	
	2'd4:
		assign R_DeOpSeleccionada = i_op1 / i_op2;

	2'd5:
		assign R_DeOpSeleccionada = i_op1 | i_op2;

	2'd6:
		assign R_DeOpSeleccionada = i_op1 << i_op2;

	2'd7:
		assign R_DeOpSeleccionada = i_op1 ^ i_op2;
endcase


end
endmodule