`timescale 1ns/100ps

module counter_99(
    input               clk      ,   
    input               rst_n    ,
    output  reg [6:0]  counter 
); 

always@(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        counter     <= 7'b0; 
    end
    else begin
        if (counter == 7'd99) begin
            counter     <= 7'b0;
        end
        else begin
            counter     <= counter + 7'b1;
        end
    end
end

endmodule