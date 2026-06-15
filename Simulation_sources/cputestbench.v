module processortb;
reg clk,reset;
wire[31:0] resultw;
cpu rv32i(clk,reset,resultw);
initial begin
    clk=0;
    reset=0;
end
always #5 clk = ~clk;

initial begin
    #2 reset=1;
    #1 reset=0;
    #5000 $finish;
end
initial begin
    $dumpfile("processor.vcd");
    $dumpvars(0,processortb);
end
endmodule