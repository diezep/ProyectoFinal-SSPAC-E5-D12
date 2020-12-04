`timescale 1ns/1ns
module test_datapath ();
    
reg clk_tb = 1;
wire[31:0] result_tb;

DATAPATH datapath(
    .clk(clk_tb),
    .result(result_tb)
);

always @(*) begin
    #5;
    clk_tb =! clk_tb;    
end

initial
begin
  $readmemb("C:/Users/PC/Desktop/Datapath/ProyectoFinal-SSPAC-E5-D12-main/bank_registers.txt", datapath.bancoRegistros.br);
  #100;
  $readmemb("C:/Users/PC/Desktop/Datapath/ProyectoFinal-SSPAC-E5-D12-main/instructions.txt", datapath.intructionMemory.Imem);
end

endmodule