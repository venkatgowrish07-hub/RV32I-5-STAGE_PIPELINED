module cpu(
    input clk,
    input reset,
    output [31:0] resultw
);

    wire pcsrce;
    wire stallf;

    wire [31:0] pc;
    wire [31:0] pc4;
    wire [31:0] pctargete;
    wire [31:0] data;
    wire [31:0] counter;

    programcounter programcounter(
        .clk(clk),
        .reset(reset),
        .pcsrce(pcsrce),
        .stallf(stallf),
        .pc4(pc4),
        .pctargete(pctargete),
        .pc(pc)
    );

    pcplus4 pcplus4(
        .pc(pc),
        .pc4(pc4)
    );

    wire [31:0] instr;

    instr_memo instr_memo(
        .pc(pc),
        .instr(instr)
    );

    wire stalld;
    wire flushd;

    wire [31:0] dinstr;
    wire [31:0] dpc4;
    wire [31:0] dpc;

    regIF_ID reg1(
        .clk(clk),
        .reset(reset),
        .stalld(stalld),
        .flushd(flushd),
        .instr(instr),
        .pc4(pc4),
        .pc(pc),
        .dinstr(dinstr),
        .dpc4(dpc4),
        .dpc(dpc)
    );

    wire [6:0] opcode;
    wire [24:0] imm;
    wire [4:0] rs1;
    wire [4:0] rs2;
    wire [4:0] rd;
    wire [2:0] funct3;
    wire [6:0] funct7;

    instr_decoder instr_decoder(
        .dinstr(dinstr),
        .opcode(opcode),
        .imm(imm),
        .rs1(rs1),
        .rs2(rs2),
        .funct3(funct3),
        .rd(rd),
        .funct7(funct7)
    );

    wire [31:0] rd1;
    wire [31:0] rd2;

    wire [31:0] resw;
    wire wregwrite;
    wire [4:0] wrd;

    reg_file reg_file(
        .clk(clk),
        .ra1(rs1),
        .ra2(rs2),
        .wa3(wrd),
        .wd3(resw),
        .we3(wregwrite),
        .rd1(rd1),
        .rd2(rd2)
    );

    wire dregwrite;
    wire dalusrc;
    wire dmemwrite;
    wire dbranch;
    wire djump;

    wire [1:0] daluop;
    wire [1:0] dimmsrc;
    wire [1:0] dresultsrc;

    control_unit control_unit(
        .opcode(opcode),
        .dregwrite(dregwrite),
        .dalusrc(dalusrc),
        .dmemwrite(dmemwrite),
        .daluop(daluop),
        .dbranch(dbranch),
        .dimmsrc(dimmsrc),
        .dresultsrc(dresultsrc),
        .djump(djump)
    );

    wire [31:0] immext;

    sign_ext sign_ext(
        .imm(imm),
        .dimmsrc(dimmsrc),
        .immext(immext)
    );

    wire [2:0] daluctrl;

    alu_control alu_control(
        .aluop(daluop),
        .funct3(funct3),
        .funct7(funct7),
        .aluctrl(daluctrl)
    );

    wire flushe;

    wire [31:0] epc4;
    wire [31:0] eimmext;
    wire [31:0] epc;
    wire [31:0] erd1;
    wire [31:0] erd2;

    wire [4:0] erd;
    wire [4:0] ers1;
    wire [4:0] ers2;

    wire ealusrc;
    wire ebranch;
    wire ejump;
    wire ememwrite;
    wire eregwrite;

    wire [1:0] forwardae;
    wire [1:0] forwardbe;

    wire [31:0] A;
    wire [31:0] B;
    wire [31:0] ewritedata;

    wire [31:0] resulte;

    wire [2:0] ealuctrl;
    wire [1:0] eresultsrc;

    wire [31:0] resultm;
    wire [31:0] mpc4;
    wire [31:0] mwritedata;

    wire [4:0] mrd;

    wire mregwrite;
    wire mmemwrite;

    wire [1:0] mresultsrc;

    regID_EXE reg2(
        .clk(clk),
        .reset(reset),
        .flushe(flushe),
        .dpc4(dpc4),
        .immext(immext),
        .rd(rd),
        .rs1(rs1),
        .rs2(rs2),
        .dpc(dpc),
        .rd1(rd1),
        .rd2(rd2),
        .dalusrc(dalusrc),
        .daluctrl(daluctrl),
        .dbranch(dbranch),
        .djump(djump),
        .dmemwrite(dmemwrite),
        .dresultsrc(dresultsrc),
        .dregwrite(dregwrite),
        .epc4(epc4),
        .eimmext(eimmext),
        .erd(erd),
        .ers1(ers1),
        .ers2(ers2),
        .epc(epc),
        .erd1(erd1),
        .erd2(erd2),
        .ealusrc(ealusrc),
        .ealuctrl(ealuctrl),
        .ebranch(ebranch),
        .ejump(ejump),
        .ememwrite(ememwrite),
        .eresultsrc(eresultsrc),
        .eregwrite(eregwrite)
    );

    assign A =
        (forwardae == 2'b00) ? erd1 :
        (forwardae == 2'b10) ? resultm :
        (forwardae == 2'b01) ? resw :
                               erd1;

    assign ewritedata =
        (forwardbe == 2'b00) ? erd2 :
        (forwardbe == 2'b10) ? resultm :
        (forwardbe == 2'b01) ? resw :
                               erd2;

    assign B = (ealusrc) ? eimmext : ewritedata;

    wire zero;

    alu alu(
        .ealuctrl(ealuctrl),
        .A(A),
        .B(B),
        .resulte(resulte),
        .zero(zero)
    );

    wire [31:0] epctarget;

    pcadder pcadder(
        .epc(epc),
        .eimmext(eimmext),
        .epctarget(epctarget)
    );

    regEXE_MEM reg3(
        .clk(clk),
        .reset(reset),
        .resulte(resulte),
        .epc4(epc4),
        .erd(erd),
        .ewritedata(ewritedata),
        .eregwrite(eregwrite),
        .eresultsrc(eresultsrc),
        .ememwrite(ememwrite),
        .resultm(resultm),
        .mpc4(mpc4),
        .mrd(mrd),
        .mwritedata(mwritedata),
        .mregwrite(mregwrite),
        .mresultsrc(mresultsrc),
        .mmemwrite(mmemwrite)
    );

    wire [31:0] readdata;

    datamemory datamemory(
        .clk(clk),
        .resultm(resultm),
        .mwritedata(mwritedata),
        .mmemwrite(mmemwrite),
        .readdata(readdata)
    );

    wire [31:0] wreaddata;
    wire [31:0] wpc4;
    wire [31:0] resultw;

    wire [1:0] wresultsrc;

    regMEM_WB reg4(
        .clk(clk),
        .reset(reset),
        .readdata(readdata),
        .mregwrite(mregwrite),
        .mresultsrc(mresultsrc),
        .resultm(resultm),
        .mrd(mrd),
        .mpc4(mpc4),
        .wreaddata(wreaddata),
        .wregwrite(wregwrite),
        .wresultsrc(wresultsrc),
        .resultw(resultw),
        .wrd(wrd),
        .wpc4(wpc4)
    );

    mux mux(
        .wresultsrc(wresultsrc),
        .wreaddata(wreaddata),
        .resultw(resultw),
        .wpc4(wpc4),
        .resw(resw)
    );

    assign pcsrce = 1'b0;

    hazard_control2 hazard(
        .rs1d(rs1),
        .rs2d(rs2),
        .rs1e(ers1),
        .rs2e(ers2),
        .rde(erd),
        .rdm(mrd),
        .rdw(wrd),
        .resultsrce(eresultsrc),
        .regwritem(mregwrite),
        .regwritew(wregwrite),
        .pcsrce(pcsrce),
        .forwardae(forwardae),
        .forwardbe(forwardbe),
        .stallf(stallf),
        .stalld(stalld),
        .flushd(flushd),
        .flushe(flushe)
    );

endmodule
