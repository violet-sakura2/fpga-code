`timescale 1ns/100ps

module counter_99_div10(
    input               clk      ,   
    input               rst_n    ,
    output  reg [6:0]  counter 
); 

reg [3:0] div_cnt;

always@(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        div_cnt     <= 4'd0;
        counter     <= 7'b0; 
    end
    else begin
        if (div_cnt == 4'd9) begin
            div_cnt     <= 4'd0;
            if (counter == 7'd99) begin
                counter     <= 7'b0;
            end
            else begin
                counter     <= counter + 7'b1;
            end
        end
        else begin
            div_cnt     <= div_cnt + 4'd1;
        end
    end
end

endmodule