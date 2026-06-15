module regMEM_WB(
    input clk,
    input reset,
    input [31:0] readdata,
    input mregwrite,
    input [1:0] mresultsrc,
    input [31:0] resultm,
    input [4:0] mrd,
    input [31:0] mpc4,
    output reg [31:0] wreaddata,
    output reg wregwrite,
    output reg [1:0] wresultsrc,
    output reg [31:0] resultw,
    output reg [4:0] wrd,
    output reg [31:0] wpc4
);
    always @(posedge clk) begin
        if (reset) begin
            wreaddata <= 32'b0;
            wregwrite <= 1'b0;
            wresultsrc <= 2'b00;
            resultw <= 32'b0;
            wrd <= 5'b0;
            wpc4 <= 32'b0;
        end else begin
            wreaddata <= readdata;
            wregwrite <= mregwrite;
            wresultsrc <= mresultsrc;
            resultw <= resultm;
            wrd <= mrd;
            wpc4 <= mpc4;
        end
    end

endmodule
