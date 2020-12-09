module ALUC (
    input[5:0] func,
    input[3:0] UC_aluOp,
    output reg[3:0] ALU_aluOp
);


always @*
    begin
        case(UC_aluOp)
            4'b0001:        //Addi
                begin
                  ALU_aluOp <= 4'b0010;
                end
            4'b0000:     //Andi
                begin
                  ALU_aluOp <= 4'b0000;
                end
            4'b0010:     //Ori
                begin
                  ALU_aluOp <= 4'b0001;
                end
            4'b0011:     //slti
                begin
                  ALU_aluOp <= 4'b0100;
                end
            4'b0101:     //Branch on equal
                begin
                  ALU_aluOp <= 4'b0011;
                end

            4'b0100:     //Save word
                begin
                  ALU_aluOp <= 4'b0010;
                end
            
            4'b1000:    //Load word
                begin
                  ALU_aluOp <= 4'b0010;
                end   

            4'b0111:             //R
                begin
                    case(func)
                        // AND
                        6'b100100: 
                            ALU_aluOp <= 4'b0000;
                        // OR
                        6'b100101: 
                            ALU_aluOp <= 4'b0001;
                        // ADD
                        6'b100000: 
                            ALU_aluOp <= 4'b0010;
                        // SUB
                        6'b100010: 
                            ALU_aluOp <= 4'b0011;
                        // SLT
                        6'b101010: 
                            ALU_aluOp <= 4'b0100;
                        // DIV
                        6'b011010: 
                            ALU_aluOp <= 4'b0101;
                        // NOP
                        6'b000000: 
                            ALU_aluOp <= 4'b0110;
                        // MULT
                        6'b011000: 
                            ALU_aluOp <= 4'b0111;
                        
                        6'b100110:
                            ALU_aluOp <= 4'b1111;
                    endcase
                end
        endcase
    end
endmodule
