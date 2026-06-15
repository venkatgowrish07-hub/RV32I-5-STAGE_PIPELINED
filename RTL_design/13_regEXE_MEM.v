module regEXE_MEM(
    input clk,
    input reset,
    
    input [31:0] resulte,
    input [31:0] epc4,
    input [4:0] erd,
    input [31:0] ewritedata,
    input eregwrite,
    input [1:0] eresultsrc,
    input ememwrite,

    output reg [31:0] resultm,
    output reg [31:0] mpc4,
    output reg [4:0] mrd,
    output reg [31:0] mwritedata,
    output reg mregwrite,
    output reg [1:0] mresultsrc,
    output reg mmemwrite
);
    always @(posedge clk) begin
        if (reset) begin
            resultm <= 32'b0;
            mpc4 <= 32'b0;
            mrd <= 5'b0;
            mwritedata <= 32'b0;
            mregwrite <= 1'b0;
            mresultsrc <= 2'b00;
            mmemwrite <= 1'b0;
        end else begin
            resultm <= resulte;
            mpc4 <= epc4;
            mrd <= erd;
            mwritedata <= ewritedata;
            mregwrite <= eregwrite;
            mresultsrc <= eresultsrc;
            mmemwrite <= ememwrite;
        end
    end
endmodule
