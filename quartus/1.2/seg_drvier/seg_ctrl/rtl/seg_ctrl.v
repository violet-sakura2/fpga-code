`timescale 1ns/100ps

module seg_ctrl (
    input               clk    ,
    input               rst_n  ,
    output              sdi    ,
    output              sclk   ,
    output              load   
);

wire               clk_200hz   ;
wire               clk_10hz    ;
wire    [6:0]      counter_val ;

reg     [7:0]      tens_dight  ;
reg     [7:0]      units_digit ;
wire    [15:0]     hex2_data   ;

wire    [7:0]      seg_tens    ;    
wire    [7:0]      seg_units   ;  

clk_gen u_clk_gen (
    .clk            ( clk            ),
    .rst_n          ( rst_n          ),
    .clk_200hz      ( clk_200hz      ),
    .clk_10hz       ( clk_10hz       )  
);

counter_99 u_counter_99 (
    .clk            ( clk_10hz       ),
    .rst_n          ( rst_n          ),
    .counter        ( counter_val    )
); 

always @(*) begin
    tens_dight  = counter_val / 10;
    units_digit = counter_val % 10;
end

assign seg_tens  = (tens_dight  == 4'd0) ? 8'b1100_0000 :
                   (tens_dight  == 4'd1) ? 8'b1111_1001 : 
                   (tens_dight  == 4'd2) ? 8'b1010_0100 : 
                   (tens_dight  == 4'd3) ? 8'b1011_0000 :
                   (tens_dight  == 4'd4) ? 8'b1001_1001 : 
                   (tens_dight  == 4'd5) ? 8'b1001_0010 : 
                   (tens_dight  == 4'd6) ? 8'b1000_0010 : 
                   (tens_dight  == 4'd7) ? 8'b1111_1000 :
                   (tens_dight  == 4'd8) ? 8'b1000_0000 : 
                   (tens_dight  == 4'd9) ? 8'b1001_0000 : 8'b1111_1111;

assign seg_units = (units_digit == 4'd0) ? 8'b1111_1110 : 
                   (units_digit == 4'd1) ? 8'b1111_1001 : 
                   (units_digit == 4'd2) ? 8'b1010_0100 : 
                   (units_digit == 4'd3) ? 8'b1011_0000 :
                   (units_digit == 4'd4) ? 8'b1001_1001 : 
                   (units_digit == 4'd5) ? 8'b1001_0010 : 
                   (units_digit == 4'd6) ? 8'b1000_0010 : 
                   (units_digit == 4'd7) ? 8'b1111_1000 : 
                   (units_digit == 4'd8) ? 8'b1000_0000 : 
                   (units_digit == 4'd9) ? 8'b1001_0000 : 8'b1111_1111;

assign hex2_data = {seg_units, seg_tens};

static_seg u_static_seg (
    .clk            ( clk            ),
    .rst_n          ( rst_n          ),
    .data           ( hex2_data      ),
    .DIO            ( sdi            ),
    .SRCLK          ( sclk           ),
    .RCLK           ( load           )
);

endmodule