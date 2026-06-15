module alu_control(
    input  [1:0] aluop,
    input  [2:0] funct3,
    input  [6:0] funct7,
    output reg [2:0] aluctrl
);

    always @(*) begin
        case (aluop)

            // lw, sw, addi → ADD
            2'b00: aluctrl = 3'b000;

            // beq → SUB
            2'b01: aluctrl = 3'b001;

            // R-type
            2'b10: begin
                case (funct3)
                    3'b000: aluctrl = (funct7[5]) ? 3'b001 : 3'b000; // sub / add
                    3'b111: aluctrl = 3'b010; // AND
                    3'b110: aluctrl = 3'b011; // OR
                    3'b010: aluctrl = 3'b100; // SLT
                    default: aluctrl = 3'b000;
                endcase
            end

            default: aluctrl = 3'b000;

        endcase
    end

endmodule

