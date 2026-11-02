`timescale 1ns/1ps

module hello_world_tb ();

    reg Clk;
    reg Reset_n;
    reg key_0;
    reg key_1;
    wire led_0;
    wire led_1;

hello_world hello_world_inst0(
    .Clk(Clk),
    .Reset_n(Reset_n),
    .key_0(key_0),
    .key_1(key_1),
    .led_0(led_0),
    .led_1(led_1)
);

initial  Clk=0;
always #10 Clk=~Clk;

initial begin
    Reset_n=0;key_0=1;key_1=1;
    #101;
    Reset_n=1;
    #100 key_0=0;
    #200 key_0=1;
    #100 key_1=0;
    #200 key_1=1;
    #100 $stop;
end

endmodule