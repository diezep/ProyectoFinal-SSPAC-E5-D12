module bank(
    input [31:0]din, 
    input [4:0]ra1,
    input [4:0]ra2,
    input [4:0]wa,
    input rw,
    output reg [31:0]dr1,
    output reg [31:0]dr2
);

reg [31:0]br[0:31];

initial
begin
    br[3] = 32'd100;
    br[0] = 32'd49;
    br[1] = 32'd333;
    br[5] = 32'd752;
    br[2] = 32'd125;
    br[6] = 32'd25;
    br[4] = 32'd14;
    br[7] = 32'd7;
    br[8] = 32'd98;
    br[10] = 32'd666;
    br[11] = 32'd1080;
    br[9] = 32'd720;
    br[13] = 32'd570;
    br[12] = 32'd177;
    br[14] = 32'd84;
    br[15] = 32'd29;
    br[16] = 32'd9;
    br[18] = 32'd74;
    br[17] = 32'd23;
    br[20] = 32'd999;
    br[19] = 32'd1500;
    br[21] = 32'd3000;
    br[22] = 32'd1850;
    br[24] = 32'd20000;
    br[23] = 32'd45000;
end

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
