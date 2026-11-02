`timescale 1ns/100ps

module hc595_16bit(
    input               clk     ,
    input               rst_n   ,
    input       [15:0]  data    ,  // 只接收 16 位拼接好的数据
    output  reg         DIO     ,
    output  reg         SRCLK   ,
    output  reg         RCLK       
);

parameter CLOCK_FREQ = 50_000_000;
parameter SRCLK_FREQ = 12_500_000;
parameter MCNT = CLOCK_FREQ/(SRCLK_FREQ*2) - 1;

reg [29:0]  div_cnt;
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) div_cnt <= 0;
    else if (div_cnt == MCNT) div_cnt <= 0;
    else div_cnt <= div_cnt + 1;
end

reg [4:0] cnt;
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) cnt <= 0;
    else if (div_cnt == MCNT) begin
        if (cnt == 5'd31) cnt <= 0;
        else cnt <= cnt + 1;
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        DIO <= 0; SRCLK <= 0; RCLK <= 0;
    end
    else if (div_cnt == MCNT) begin
        case (cnt)
            0  : begin DIO <= data[15]; SRCLK <= 0; RCLK <= 1; end
            1  : begin SRCLK <= 1; RCLK <= 0; end
            2  : begin DIO <= data[14]; SRCLK <= 0; end
            3  : begin SRCLK <= 1; end
            4  : begin DIO <= data[13]; SRCLK <= 0; end
            5  : begin SRCLK <= 1; end
            6  : begin DIO <= data[12]; SRCLK <= 0; end
            7  : begin SRCLK <= 1; end
            8  : begin DIO <= data[11]; SRCLK <= 0; end
            9  : begin SRCLK <= 1; end
            10 : begin DIO <= data[10]; SRCLK <= 0; end
            11 : begin SRCLK <= 1; end
            12 : begin DIO <= data[9]; SRCLK <= 0; end
            13 : begin SRCLK <= 1; end
            14 : begin DIO <= data[8]; SRCLK <= 0; end
            15 : begin SRCLK <= 1; end
            16 : begin DIO <= data[7]; SRCLK <= 0; end
            17 : begin SRCLK <= 1; end
            18 : begin DIO <= data[6]; SRCLK <= 0; end
            19 : begin SRCLK <= 1; end
            20 : begin DIO <= data[5]; SRCLK <= 0; end
            21 : begin SRCLK <= 1; end
            22 : begin DIO <= data[4]; SRCLK <= 0; end
            23 : begin SRCLK <= 1; end
            24 : begin DIO <= data[3]; SRCLK <= 0; end
            25 : begin SRCLK <= 1; end
            26 : begin DIO <= data[2]; SRCLK <= 0; end
            27 : begin SRCLK <= 1; end
            28 : begin DIO <= data[1]; SRCLK <= 0; end
            29 : begin SRCLK <= 1; end
            30 : begin DIO <= data[0]; SRCLK <= 0; end
            31 : begin SRCLK <= 1; end        
        endcase
    end
end

endmodule