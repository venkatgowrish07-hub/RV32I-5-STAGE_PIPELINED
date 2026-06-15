module programcounter (
    input clk,
    input reset,
    input pcsrce,
    input stallf,
    input [31:0] pc4,
    input [31:0] pctargete,
    output reg [31:0] pc
);

always @(posedge clk or posedge reset) begin
    if (reset)
        pc <= 32'b0;
    else if (!stallf) begin
        if (pcsrce)
            pc <= pctargete;
        else
            pc <= pc4;
    end
end

endmodule