module top_module(
    input clk,
    input reset,
    output [6:0] seg,
    output [3:0] an
);

wire slowclk;
wire [31:0] result;

wire [3:0] ones;
wire [3:0] tens;
wire [3:0] hundreds;
wire [3:0] thousands;

clk_divider divider(
    .clk(clk),
    .reset(reset),
    .clk1(slowclk)
);

cpu processor(
    .clk(slowclk),
    .reset(reset),
    .resultw(result)
);

bin_to_bcd convert(
    .bin(result),
    .ones(ones),
    .tens(tens),
    .hundreds(hundreds),
    .thousands(thousands)
);

display_mux display(
    .clk(clk),
    .d0(ones),
    .d1(tens),
    .d2(hundreds),
    .d3(thousands),
    .an(an),
    .seg(seg)
);

endmodule