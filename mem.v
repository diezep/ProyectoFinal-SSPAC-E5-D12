module mem(
    input [31:0]dati,
    input memwrite,
    input memread,
    input [31:0]dir,
    output reg [31:0]dato
);

reg [31:0]memo[0:31];


always @*
begin
    if(memwrite==1)
    begin
        memo[dir]=dati;
    end

    if(memread==1)
    begin
        dato=memo[dir];
    end
end
endmodule