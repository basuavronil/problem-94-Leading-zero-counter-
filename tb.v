`timescale 1ns / 1ps

module tb_leading_zero_counter_8bit;

    // Inputs
    reg       clk;
    reg       rst_n;
    reg [7:0] data_in;

    // Outputs
    wire [3:0] count_out;
    wire       zero_flag;

    // Instantiate the Unit Under Test (UUT)
    leading_zero_counter_8bit uut (
        .clk(clk),
        .rst_n(rst_n),
        .data_in(data_in),
        .count_out(count_out),
        .zero_flag(zero_flag)
    );

    // Clock generation (100MHz -> 10ns period)
    always #5 clk = ~clk;

    initial begin
        // Setup waveform dumping
        $dumpfile("waveform.vcd");
        $dumpvars(0, tb_leading_zero_counter_8bit);

        // Setup automatic terminal logging
        $monitor("Time=%0t ns | rst_n=%b | data_in=8'b%b | count_out=%0d | zero_flag=%b",
                 $time, rst_n, data_in, count_out, zero_flag);

        // Initialize signals
        clk     = 0;
        rst_n   = 0;
        data_in = 8'b0;

        // Apply reset
        #15;
        rst_n = 1;
        #10;

        // Test Case 1: MSB set (0 leading zeros)
        data_in = 8'b1010_1010; #10;
        
        // Test Case 2: Bit 6 set (1 leading zero)
        data_in = 8'b0110_0000; #10;

        // Test Case 3: Bit 4 set (3 leading zeros)
        data_in = 8'b0001_1111; #10;

        // Test Case 4: LSB set (7 leading zeros)
        data_in = 8'b0000_0001; #10;

        // Test Case 5: All zeros (8 leading zeros + zero_flag set)
        data_in = 8'b0000_0000; #10;

        // Test Case 6: Random value (5 leading zeros)
        data_in = 8'b0000_0100; #10;

        // Finish simulation
        $display("Simulation finished successfully.");
        $finish;
    end

endmodule
