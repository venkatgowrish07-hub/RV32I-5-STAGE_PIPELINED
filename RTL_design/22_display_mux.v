module display_mux(
    input clk,
    input [3:0] d0,
    input [3:0] d1,
    input [3:0] d2,
    input [3:0] d3,
    output reg [3:0] an,
    output [7:0] seg
);

reg [1:0] sel;
reg [3:0] digit;
reg [15:0] refresh_counter;

always @(posedge clk)
    refresh_counter <= refresh_counter + 1;

always @(posedge clk)
    sel <= refresh_counter[15:14];

always @(*) begin
    case(sel)
        2'b00: begin
            an = 4'b1110;
            digit = d0;
        end

        2'b01: begin
            an = 4'b1101;
            digit = d1;
        end

        2'b10: begin
            an = 4'b1011;
            digit = d2;
        end

        2'b11: begin
            an = 4'b0111;
            digit = d3;
        end
    endcase
end

seg7_decoder decoder(
    .num(digit),
    .seg(seg)
);

endmodule