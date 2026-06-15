module clk_divider(
    input clk, 
    input reset, 
    output reg clk1
);

    reg [26:0] counter ;

    always @ (posedge clk or posedge reset) begin
        if(reset) begin
            counter <= 27'd1 ;
            clk1 <= 1'b0 ;
        end
        else begin 
            if(counter == 27'd50_000000) begin
                clk1 <= ~clk1 ;
                counter <= 27'd1 ;
            end
            else counter <= counter +  1;
        end

    end
    

endmodule 