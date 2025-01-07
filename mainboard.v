module mainboard (
    input wire clk,                // Input clock (50 MHz)
    input wire reset,              // Reset signal
    input wire [15:0] temp_data,   // 16-bit temperature data input
    output reg alarm,              // Alarm output
    output reg [15:0] display      // 16-bit output for temperature display
);

// Parameters
parameter THRESHOLD = 16'd500;    // Temperature threshold in 0.1°C
parameter TIME_DELAY = 4'd10;     // Delay time in seconds
parameter INPUT_CLK_FREQ = 50_000_000;  // Input clock frequency
parameter OUTPUT_CLK_FREQ = 1;         // Desired output frequency
localparam DIVIDER_LIMIT = (INPUT_CLK_FREQ / (2 * OUTPUT_CLK_FREQ)) - 1;


// Internal Registers
reg [31:0] clk_divider;           // Clock divider for 1 Hz generation
reg one_sec_clk;                  // 1 Hz clock signal
reg [3:0] timer_counter;          // Timer to count seconds above threshold

// ** Clock Divider Logic **
always @(posedge clk or posedge reset) begin
    if (reset) begin
        clk_divider <= 32'b0;
        one_sec_clk <= 1'b0;
    end else if (clk_divider == DIVIDER_LIMIT) begin
        clk_divider <= 32'b0;
        one_sec_clk <= ~one_sec_clk;
    end else begin
        clk_divider <= clk_divider + 1;  // Ensure this line is clean of any invalid characters
    end
end

// ** Timer and Alarm Control Logic **
always @(posedge one_sec_clk or posedge reset) begin
    if (reset) begin
        timer_counter <= 4'b0;
        alarm <= 1'b0;
        display <= 16'b0;
    end else begin
        // Update Display with Current Temperature
        display <= temp_data;
        
        // Check if Temperature Exceeds Threshold
        if (temp_data >= THRESHOLD) begin
            if (timer_counter < TIME_DELAY) begin
                timer_counter <= timer_counter + 1; // Increment timer
                alarm <= 1'b0; // Wait until delay is met
            end else begin
                alarm <= 1'b1; // Activate alarm
            end
        end else begin
            timer_counter <= 4'b0; // Reset timer if temperature drops
            alarm <= 1'b0; // Deactivate alarm
        end
    end
end

endmodule
