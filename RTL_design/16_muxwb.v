module mux (
    input [1:0] wresultsrc ,
    input [31:0] wreaddata ,
    input [31:0] resultw ,
    input [31:0] wpc4 ,
    output reg [31:0] resw 
);

    always @ (*) begin
        case(wresultsrc)
            2'b00 : resw <= resultw ;
            2'b01 : resw <= wreaddata ;
            2'b10 : resw <= wpc4 ;
        endcase
    end

endmodule 