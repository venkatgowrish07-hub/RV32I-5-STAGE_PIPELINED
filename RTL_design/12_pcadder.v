module pcadder (
    input [31:0] epc , 
    input [31:0] eimmext , 
    output [31:0] epctarget 
);

    assign epctarget = epc + eimmext;

endmodule