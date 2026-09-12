module leading_zero_counter_8bit (
    input  wire [7:0] data_in,
    output reg  [3:0] count_out,
    output wire       zero_flag
);

    assign zero_flag = (data_in == 8'b0);

    always @(*) begin
        casez (data_in)
            8'b1???????: count_out = 4'd0;
            8'b01??????: count_out = 4'd1;
            8'b001?????: count_out = 4'd2;
            8'b0001????: count_out = 4'd3;
            8'b00001???: count_out = 4'd4;
            8'b000001??: count_out = 4'd5;
            8'b0000001?: count_out = 4'd6;
            8'b00000001: count_out = 4'd7;
            default:     count_out = 4'd8; // All zeros
        endcase
    end

endmodule
