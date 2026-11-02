`timescale 1ns/100ps

module dyn_ctrl (
    input               clk    ,
    input               rst_n  ,
    output              sdi    ,
    output              sclk   ,
    output              load   
);

wire               clk_200hz   ;
wire               clk_10hz    ;
wire    [6:0]      counter_val ;

reg     [3:0]      tens_dight  ;
reg     [3:0]      units_digit ;
wire    [31:0]     hex8_data   ;

wire    [7:0]      seg_out     ;
wire    [7:0]      sel_out     ;
reg     [15:0]     data_16bit  ;

clk_gen u_clk_gen (
    .clk            ( clk            ),
    .rst_n          ( rst_n          ),
    .clk_200hz      ( clk_200hz      ),
    .clk_10hz       ( clk_10hz       )  
);

counter_99_div10 u_counter_99_div10 (
    .clk            ( clk_10hz       ),
    .rst_n          ( rst_n          ),
    .counter        ( counter_val    )
); 

always @(*) begin
    tens_dight  = counter_val / 10;
    units_digit = counter_val % 10;
end

assign hex8_data = {24'b0, units_digit, tens_dight};

hex8 u_hex8 (
    .clk            ( clk            ),
    .rst_n          ( rst_n          ),
    .data           ( hex8_data      ),
    .sel            ( sel_out        ),
    .seg            ( seg_out        )
);

// 4. 桥梁：利用 hex8 的位选信号，把段码抓取下来，拼成 16 位
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        data_16bit <= 16'd0;
    end
    else begin
        if (sel_out == 8'b0000_0001) begin
            data_16bit[7:0]  <= seg_out; 
        end
        else if (sel_out == 8'b0000_0010) begin
            data_16bit[15:8] <= seg_out; 
        end
    end
end

hc595_16bit u_hc595_16bit (
    .clk            ( clk            ),
    .rst_n          ( rst_n          ),
    .data           ( data_16bit     ),
    .DIO            ( sdi            ),
    .SRCLK          ( sclk           ),
    .RCLK           ( load           )
);

endmodule