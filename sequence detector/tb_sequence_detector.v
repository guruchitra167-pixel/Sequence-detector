`timescale 1ns/1ps

module tb_sequence_detector;

    reg clk;
    reg reset;
    reg data_in;

    wire detect;

    // Instantiate sequence detector
    sequence_detector uut (
        .clk(clk),
        .reset(reset),
        .data_in(data_in),
        .detect(detect)
    );

    // Clock generation
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    // Generate waveform
    initial begin
        $dumpfile("sequence_detector.vcd");
        $dumpvars(0, tb_sequence_detector);
    end

    // Monitor
    initial begin
        $monitor(
            "Time=%0t | Reset=%b | Data=%b | Detect=%b",
            $time,
            reset,
            data_in,
            detect
        );
    end

    // Send one bit
    task send_bit(input bit_value);
        begin
            @(negedge clk);
            data_in = bit_value;
        end
    endtask

    initial begin

        // Initial values
        reset = 1'b1;
        data_in = 1'b0;

        #10;

        reset = 1'b0;

        // --------------------------------
        // Detect 1011
        // --------------------------------

        send_bit(1'b1);
        send_bit(1'b0);
        send_bit(1'b1);
        send_bit(1'b1);

        // --------------------------------
        // Extra bits
        // --------------------------------

        send_bit(1'b0);
        send_bit(1'b1);
        send_bit(1'b1);

        #10;

        $finish;

    end

endmodule