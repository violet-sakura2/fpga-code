`timescale 1ns/100ps

module clk_gen(
    input           clk         ,
    input           rst_n       ,
    output  reg     clk_200hz   ,
    output  reg     clk_10hz   
);

reg     [16:0]      clk_200hz_cnt   ;
reg     [3:0]       clk_10hz_cnt    ;

always@(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        clk_200hz_cnt <= 17'b0;
        clk_200hz     <= 1'b0;
    end
    else begin
        if (clk_200hz_cnt == 17'd124999) begin
            clk_200hz_cnt    <= 17'b0;
            clk_200hz        <= ~clk_200hz;
        end
        else begin
            clk_200hz_cnt    <= clk_200hz_cnt + 17'b1;
        end
    end
end

always@(posedge clk_200hz or negedge rst_n) begin
    if (!rst_n) begin
        clk_10hz_cnt <= 4'b0 ;
        clk_10hz     <= 1'b0 ;
    end
    else begin
        if (clk_10hz_cnt == 4'd9) begin
            clk_10hz_cnt    <= 4'b0;
            clk_10hz        <= ~clk_10hz;
        end
        else begin
            clk_10hz_cnt    <= clk_10hz_cnt + 4'b1;
        end
    end
end

endmodule



