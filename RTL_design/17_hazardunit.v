module hazard_control2(
    input  [4:0] rs1d,
    input  [4:0] rs2d,
    input  [4:0] rs1e,
    input  [4:0] rs2e,

    input  [4:0] rde,
    input  [4:0] rdm,
    input  [4:0] rdw,

    input  [1:0] resultsrce,
    input  regwritem,
    input  regwritew,
    input  pcsrce,

    output reg [1:0] forwardae,
    output reg [1:0] forwardbe,

    output reg stallf,
    output reg stalld,
    output reg flushd,
    output reg flushe
);

always @(*) begin
    forwardae = 2'b00;
    forwardbe = 2'b00;
    stallf = 1'b0;
    stalld = 1'b0;
    flushd = 1'b0;
    flushe = 1'b0;

    if (regwritem && (rdm != 5'd0) && (rdm == rs1e)) begin 
        forwardae = 2'b10;
    end

    else if (regwritew && (rdw != 5'd0) && (rdw == rs1e)) begin 
        forwardae = 2'b01;
    end

    if (regwritem && (rdm != 5'd0) && (rdm == rs2e)) begin 
        forwardbe = 2'b10;
    end
    else if (regwritew && (rdw != 5'd0) && (rdw == rs2e)) begin
        forwardbe = 2'b01;
    end

    if (resultsrce[0] && (rde != 5'd0) && ((rs1d == rde) || (rs2d == rde))) begin
        stallf = 1'b1;
        stalld = 1'b1;
        flushe = 1'b1;
    end

    if (pcsrce) begin
        flushd = 1'b1;
        flushe = 1'b1;
    end
end

endmodule