module regIF_ID(
    input clk , 
    input reset ,

    input stalld ,
    input flushd , 
    input [31:0] instr , 
    input [31:0] pc4 ,
    input [31:0] pc , 

    output reg [31:0] dinstr ,
    output reg [31:0] dpc4 ,
    output reg [31:0] dpc 
);

    always @ (posedge clk) begin
            if(reset || flushd) begin 
                dinstr <= 32'b0 ;
                dpc4 <= 32'b0 ;
                dpc <= 32'b0 ;
            end
            else begin 
                if(!flushd) begin 
                    dinstr <= instr ;
                    dpc4 <= pc4 ;
                    dpc <= pc ;
                end
                else begin
                    dinstr <= dinstr ;
                    dpc4 <= dpc4 ;
                    dpc <= dpc ;
                end                    
         end
    end  
endmodule