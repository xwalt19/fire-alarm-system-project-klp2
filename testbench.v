`timescale 1ns/1ps

module testbench();

    reg clk;                    // Clock input (50 MHz)
    reg reset;                  // Reset signal
    reg [15:0] temp_data;       // Suhu input (16-bit)
    wire alarm;                 // Output alarm
    wire [15:0] display;        // Output display

    // Instantiate the module being tested
    mainboard uut (
        .clk(clk), 
        .reset(reset), 
        .temp_data(temp_data), 
        .alarm(alarm), 
        .display(display)
    );

    // Generate 50 MHz clock (20 ns period)
    initial begin
        clk = 0;
        forever #10 clk = ~clk; // Toggle clock every 10 ns
    end

    // Simulation control
    initial begin
        // Reset system
        reset = 1;
        temp_data = 16'd0;     // Set suhu ke 0
        #50 reset = 0;         // Lepas reset setelah 50 ns

        // Test Case 1: Suhu di bawah ambang batas
        temp_data = 16'd300;  // Suhu 30.0°C (di bawah THRESHOLD = 50.0°C)
        #500;                 // Tunggu beberapa siklus clock

        // Test Case 2: Suhu melebihi ambang batas
        temp_data = 16'd600;  // Suhu 60.0°C (di atas THRESHOLD = 50.0°C)
        #100000;              // Tunggu cukup lama (100 us atau lebih) untuk timer mencapai TIME_DELAY

        // Test Case 3: Suhu kembali turun
        temp_data = 16'd300;  // Suhu 30.0°C
        #50000;               // Tunggu beberapa siklus clock

        // Akhiri simulasi
        $stop;
    end

endmodule
