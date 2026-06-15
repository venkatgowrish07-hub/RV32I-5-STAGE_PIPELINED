module instr_memo(
    input [31:0] pc,
    output reg [31:0] instr
);
    reg [31:0] mem [0:31];
    initial begin
        mem[0] = 32'h00B00093; //addi x1,x0,11
        mem[1] = 32'h01600113; //addi x2,x0,22
        mem[2] = 32'h001101B3; //addi x3,x2,x1
        mem[3] = 32'h40110233; //sub x4,x2,x1
        mem[4] = 32'h00500293; //addi x5,x0,5
        mem[5] = 32'h00E00313; //addi x6,x0,14
        mem[6] = 32'h005343B3; //xor x7,x6,x5
        mem[7] = 32'h00129413; //slli x8,x5,1
        mem[8] = 32'h000004e7; //jalr x9,x0,0
    end
    always @(*) instr <= memory[pc[6:2]];

endmodule
