module alu (
    input [2:0] ealuctrl ,
    input [31:0] A ,
    input [31:0] B ,
    output reg [31:0] resulte  
);

    always @ (*) begin 
        case (ealuctrl) 
            3'b000 : resulte = A + B ;
            3'b001 : resulte = A - B ;
            3'b010 : resulte = A & B ;
            3'b011 : resulte = A | B ;
            3'b100 : resulte = ($signed(A) < $signed(B)) ? 32'b1 : 32'b0 ;
            default : resulte = 32'b0 ;
        endcase
    end

endmodule