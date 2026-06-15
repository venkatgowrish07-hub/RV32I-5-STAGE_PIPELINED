module instr_decoder (
    input [31:0] dinstr,
    output reg [6:0] opcode,
    output reg [24:0] imm,
    output reg [4:0] rs1,
    output reg [4:0] rs2,
    output reg [2:0] funct3,
    output reg [4:0] rd,
    output reg [6:0] funct7
);

    always @(*) begin

        opcode = dinstr[6:0];
        rd = dinstr[11:7];
        funct3 = dinstr[14:12];
        rs1 = dinstr[19:15];
        rs2 = dinstr[24:20];
        funct7 = dinstr[31:25];
        imm = dinstr[31:7];
        
    end

endmodule