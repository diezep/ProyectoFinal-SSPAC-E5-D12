`timescale 1ns/1ns
module test_datapathI ();
    
reg clk_tb = 1;

DATAPATH_COMPLETE datapath(
    .clk(clk_tb)
);

always 
begin
    #5 clk_tb =! clk_tb;    
end

initial 
begin
    $readmemb("TestF1_BReg.mem", datapath.bancoRegistros.br);
    $readmemb("TestF2_MemInst.mem", datapath.intructionMemory.Imem);
end

endmodule
