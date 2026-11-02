`timescale 1ns/100ps

module hex8(
    input               clk     ,
    input               rst_n   ,
    input       [31:0]  data    ,
    output  reg [7:0]   sel     ,
    output  reg [7:0]   seg     
);

parameter CLOCK_FREQ = 50_000_000;
parameter TURN_FREQ = 1000;
parameter MCNT = CLOCK_FREQ/TURN_FREQ - 1;

reg [29:0]  div_cnt;
reg [3:0] data_temp;
reg [2:0] cnt_sel;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        div_cnt <= 0;
    end 
    else begin
        if (div_cnt == MCNT) begin
            div_cnt <= 0;
        end
        else begin
            div_cnt <= div_cnt + 1'd1;
        end
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        cnt_sel <= 0;
    end 
    else begin
        if (div_cnt == MCNT) begin
            cnt_sel <= cnt_sel + 1'd1;
        end
    end
end

always @(posedge clk) begin
    case(cnt_sel)
        0   :  sel <= 8'b0000_0001;
        1   :  sel <= 8'b0000_0010;
        2   :  sel <= 8'b0000_0100;
        3   :  sel <= 8'b0000_1000;
        4   :  sel <= 8'b0001_0000;
        5   :  sel <= 8'b0010_0000;
        6   :  sel <= 8'b0100_0000;
        7   :  sel <= 8'b1000_0000;
    endcase
end

always @(posedge clk) begin
    case(data_temp)
        0   : seg <= 8'b1100_0000;//0共阳极
        1   : seg <= 8'b1111_1001;//1
        2   : seg <= 8'b1010_0100;//2
        3   : seg <= 8'b1011_0000;//3
        4   : seg <= 8'b1001_1001;//4
        5   : seg <= 8'b1001_0010;//5
        6   : seg <= 8'b1000_0010;//6
        7   : seg <= 8'b1111_1000;//7
        8   : seg <= 8'b1000_0000;//8
        9   : seg <= 8'b1001_0000;//9
        10  : seg <= 8'b1000_1000;//A
        11  : seg <= 8'b1000_0011;//b
        12  : seg <= 8'b1100_0110;//C
        13  : seg <= 8'b1010_0001;//d
        14  : seg <= 8'b1000_0110;//E
        15  : seg <= 8'b1000_1110;//F
    endcase
end

always @(*) begin
    case(cnt_sel)
        0   : data_temp = data[3:0];
        1   : data_temp = data[7:4];
        2   : data_temp = data[11:8];
        3   : data_temp = data[15:12];
        4   : data_temp = data[19:16];
        5   : data_temp = data[23:20];
        6   : data_temp = data[27:24];
        7   : data_temp = data[31:28];
    endcase
end

endmodule