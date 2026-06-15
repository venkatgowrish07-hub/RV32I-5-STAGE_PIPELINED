module bin_to_bcd(
    input [31:0] bin,
    output [3:0] thousands,
    output [3:0] hundreds,
    output [3:0] tens,
    output [3:0] ones
);

    assign ones = bin % 10;
    assign tens = (bin / 10) % 10;
    assign hundreds = (bin / 100) % 10;
    assign thousands = (bin / 1000) % 10;

endmodule