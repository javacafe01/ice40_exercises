module top (
    input  i_Clk,
    output o_LED_2
);

    localparam integer slowDownClkThreshhold = 10000000;
    reg [31:0] thresholdCounter = 0;

    reg r_LED = 1'b0;

    always @(posedge i_Clk) begin
        if (thresholdCounter > slowDownClkThreshhold) begin
            r_LED <= !r_LED;
            thresholdCounter <= 0;
        end else begin
            thresholdCounter <= thresholdCounter + 1;
        end
    end

    assign o_LED_2 = r_LED;

endmodule
