module hello_world(
    Clk,
    Reset_n,
    key_0,
    key_1,
    led_0,
    led_1
);
    input Clk;
    input Reset_n;
    input key_0;
    input key_1;
    output wire led_0;
    output reg led_1;

    assign led_0 = (key_0 == 0)?  1 : 0;

    always@(posedge Clk or negedge Reset_n)
    if(Reset_n==0)
        led_1<=0;
    else if(key_1==0)
        led_1<=1;
    else
        led_1<=0;
endmodule 
