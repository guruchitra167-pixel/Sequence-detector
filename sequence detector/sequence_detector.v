
---

# 2. Verilog Code — `sequence_detector.v`

```verilog
module sequence_detector (
    input clk,
    input reset,
    input data_in,
    output reg detect
);

    // State definitions
    parameter S0 = 2'b00;
    parameter S1 = 2'b01;
    parameter S2 = 2'b10;
    parameter S3 = 2'b11;

    reg [1:0] state;
    reg [1:0] next_state;

    // State register
    always @(posedge clk or posedge reset) begin

        if (reset)
            state <= S0;
        else
            state <= next_state;

    end

    // Next-state and output logic
    always @(*) begin

        next_state = S0;
        detect = 1'b0;

        case (state)

            // No bits detected
            S0: begin
                if (data_in)
                    next_state = S1;
                else
                    next_state = S0;
            end

            // Detected 1
            S1: begin
                if (data_in)
                    next_state = S1;
                else
                    next_state = S2;
            end

            // Detected 10
            S2: begin
                if (data_in)
                    next_state = S3;
                else
                    next_state = S0;
            end

            // Detected 101
            S3: begin
                if (data_in) begin
                    next_state = S1;
                    detect = 1'b1;
                end
                else begin
                    next_state = S2;
                end
            end

            default: begin
                next_state = S0;
                detect = 1'b0;
            end

        endcase

    end

endmodule