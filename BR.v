module BR(
    input [31:0]din, 
    input [4:0]ra1,
    input [4:0]ra2,
    input [4:0]wa,
    input rw,
    output reg [31:0]dr1,
    output reg [31:0]dr2
);

reg [31:0]br[0:31];

always@*
begin
    if(rw==1)
    begin
        br[wa]=din;
        dr1<=br[ra1];
        dr2<=br[ra2];
    end
    else
    begin
        dr1<=br[ra1];
        dr2<=br[ra2];
    end
end
endmodule
