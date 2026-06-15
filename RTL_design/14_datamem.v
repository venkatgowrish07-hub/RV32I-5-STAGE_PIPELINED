module datamemory (
    input clk , 
    input [31:0] resultm , 
    input [31:0] mwritedata ,
    input mmemwrite , 
    output reg [31:0] readdata 
);

    reg [31:0] memory [0:255] ;

    always @(posedge clk) begin 
        if(mmemwrite) begin 
            memory[resultm >> 2] <= mwritedata ;
        end
        else begin 
            readdata <= memory[resultm >> 2] ;
        end
    end

endmodule