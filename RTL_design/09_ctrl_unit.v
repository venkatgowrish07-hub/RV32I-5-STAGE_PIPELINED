module control_unit(
    input [6:0] opcode,
    output reg dregwrite,
    output reg dalusrc,
    output reg dmemwrite,
    output reg [1:0] daluop,
    output reg dbranch,
    output reg [1:0] dimmsrc,
    output reg [1:0] dresultsrc,
    output reg djump
);

    always @(*) begin
        dregwrite  = 0;
        dimmsrc    = 2'b00;
        dalusrc    = 0;
        dmemwrite  = 0;
        daluop     = 2'b00;
        dbranch    = 0;
        dresultsrc = 2'b00;
        djump      = 0;

        case (opcode)

            // lw
            7'b0000011: begin
                dregwrite  = 1;
                dimmsrc    = 2'b00;
                dalusrc    = 1;
                dmemwrite  = 0;
                dresultsrc = 2'b01;
                dbranch    = 0;
                daluop     = 2'b00;
                djump      = 0;
            end

            // sw
            7'b0100011: begin
                dregwrite  = 0;
                dimmsrc    = 2'b01;
                dalusrc    = 1;
                dmemwrite  = 1;
                dresultsrc = 2'b00;
                dbranch    = 0;
                daluop     = 2'b00;
                djump      = 0;
            end

            // R-type
            7'b0110011: begin
                dregwrite  = 1;
                dimmsrc    = 2'b00;
                dalusrc    = 0;
                dmemwrite  = 0;
                dresultsrc = 2'b00;
                dbranch    = 0;
                daluop     = 2'b10;
                djump      = 0;
            end

            // beq
            7'b1100011: begin
                dregwrite  = 0;
                dimmsrc    = 2'b10;
                dalusrc    = 0;
                dmemwrite  = 0;
                dresultsrc = 2'b00;
                dbranch    = 1;
                daluop     = 2'b01;
                djump      = 0;
            end

            // I-type ALU
            7'b0010011: begin
                dregwrite  = 1;
                dimmsrc    = 2'b00;
                dalusrc    = 1;
                dmemwrite  = 0;
                dresultsrc = 2'b00;
                dbranch    = 0;
                daluop     = 2'b10;
                djump      = 0;
            end

            // jal
            7'b1101111: begin
                dregwrite  = 1;
                dimmsrc    = 2'b11;
                dalusrc    = 0;
                dmemwrite  = 0;
                dresultsrc = 2'b10;
                dbranch    = 0;
                daluop     = 2'b00;
                djump      = 1;
            end

        endcase
    end

endmodule
