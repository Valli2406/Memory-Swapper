`timescale 1ns / 1ps

module your_module_tb;

  // Clock and control signals
  reg clk;
  reg reset_n;
  reg swap;
  reg we;

  // Address and data signals
  reg [7:0] address_w;
  reg [7:0] data_w;
  reg [7:0] address_A;
  reg [7:0] address_B;

  integer i;

  // Clock generation: 10ns period
  localparam T = 10;
  always begin
    clk = 1'b0;
    #(T/2);
    clk = 1'b1;
    #(T/2);
  end

  initial begin
    // Reset sequence
    reset_n = 1'b0;
    #2
    reset_n = 1'b1;
    swap = 1'b0;

    // Write loop: write values to addresses 20 to 29
    for (i = 20; i < 30; i = i + 1) begin
      @(negedge clk);
      address_w = i;
      data_w = i;
      we = 1'b1;
    end

    // Stop writing
    @(negedge clk);
    we = 1'b0;

    // Set addresses and trigger swap
    @(negedge clk);
    address_A = 8'd22;
    address_B = 8'd28;
    swap = 1'b1;

    // Hold swap for 3 cycles
    repeat(3) @(negedge clk);
    swap = 1'b0;

    // Finish simulation after some time
    #25 $stop;
  end

endmodule
