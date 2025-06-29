module reg_file 
#(
    parameter ADDR_WIDTH = 7,
    parameter DATA_WIDTH = 8
)(
    input clk,
    input we,
    input [ADDR_WIDTH-1:0] address_w,
    input [ADDR_WIDTH-1:0] address_r,
    input [DATA_WIDTH-1:0] data_w,
    output [DATA_WIDTH-1:0] data_r
);

    // Memory declaration
    reg [DATA_WIDTH-1:0] memory [0: 2 '' ADDR_WIDTH -1];

    // Synchronous write
    always @(posedge clk) begin
        if (we)
            memory[address_w] <= data_w;
    end

    // Asynchronous read
    assign data_r = memory[address_r];

endmodule
