module regID_EXE(
    input clk,
    input reset,
    input flushe,

    input [31:0] dpc4,
    input [31:0] immext,
    input [4:0] rd,
    input [4:0] rs1,
    input [4:0] rs2,
    input [31:0] dpc,
    input [31:0] rd1,
    input [31:0] rd2,
    input dalusrc,
    input [2:0] daluctrl,
    input dbranch,
    input djump,
    input dmemwrite,
    input [1:0] dresultsrc,
    input dregwrite,

    output reg [31:0] epc4,
    output reg [31:0] eimmext,
    output reg [4:0] erd,
    output reg [4:0] ers1,
    output reg [4:0] ers2,
    output reg [31:0] epc,
    output reg [31:0] erd1,
    output reg [31:0] erd2,
    output reg ealusrc,
    output reg [2:0] ealuctrl,
    output reg ebranch,
    output reg ejump,
    output reg ememwrite,
    output reg [1:0] eresultsrc,
    output reg eregwrite
);

    always @(posedge clk) begin

        if (reset || flushe) begin
            epc4 <= 32'b0;
            eimmext <= 32'b0;
            erd <= 5'b0;
            ers1 <= 5'b0;
            ers2 <= 5'b0;
            epc <= 32'b0;
            erd1 <= 32'b0;
            erd2 <= 32'b0;
            ealusrc <= 1'b0;
            ealuctrl <= 3'b000;
            ebranch <= 1'b0;
            ejump <= 1'b0;
            ememwrite <= 1'b0;
            eresultsrc <= 2'b00;
            eregwrite <= 1'b0;

        end 
        else begin

            epc4 <= dpc4;
            eimmext <= immext;
            erd <= rd;
            ers1 <= rs1;
            ers2 <= rs2;
            epc <= dpc;
            erd1 <= rd1;
            erd2 <= rd2;
            ealusrc <= dalusrc;
            ealuctrl <= daluctrl;
            ebranch <= dbranch;
            ejump <= djump;
            ememwrite <= dmemwrite;
            eresultsrc <= dresultsrc;
            eregwrite <= dregwrite;
            
        end
    end

endmodule
