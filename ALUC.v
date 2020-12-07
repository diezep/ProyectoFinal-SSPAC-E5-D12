module ALUC (
    input[5:0] func,
    input[2:0] UC_aluOp,
    output reg[2:0] ALU_aluOp
);


always @*
    begin
        case(UC_aluOp)
            3'b111: 
                begin
                    case(func)
                        // AND
                        6'b100100: 
                            ALU_aluOp <= 3'b000;
                        // OR
                        6'b100101: 
                            ALU_aluOp <= 3'b001;
                        // ADD
                        6'b100000: 
                            ALU_aluOp <= 3'b010;
                        // SUB
                        6'b100010: 
                            ALU_aluOp <= 3'b011;
                        // SLT
                        6'b101010: 
                            ALU_aluOp <= 3'b100;
                        // DIV
                        6'b011010: 
                            ALU_aluOp <= 3'b101;
                        // NOP
                        6'b000000: 
                            ALU_aluOp <= 3'b110;
                        // MULT
                        6'b011000: 
                            ALU_aluOp <= 3'b111;
                    endcase
                end
        endcase
    end
endmodule
