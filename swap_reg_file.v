module swap_reg_file 
#(
    parameter ADDR_WIDTH = 7,
    parameter DATA_WIDTH = 8
)(
    input clk,
    input reset_n,
    input we,
    input [DATA_WIDTH-1:0] data_w,
    input [ADDR_WIDTH-1:0] address_w,
    input [ADDR_WIDTH-1:0] address_r,
    output [DATA_WIDTH-1:0] data_r,

    // Swap functionality inputs
    input [ADDR_WIDTH-1:0] address_A,
    input [ADDR_WIDTH-1:0] address_B,
    input swap
);

    wire [1:0] sel;
    wire w;
    wire [ADDR_WIDTH-1:0] MUX_READ_f, MUX_WRITE_f;
  

    // Instantiate register file
    reg_file #(
        .ADDR_WIDTH(ADDR_WIDTH),
        .DATA_WIDTH(DATA_WIDTH)
    ) REG_FILE (
        .clk(clk),
        .we(w ? 1'b1 : we),
        .address_w(MUX_WRITE_f),
        .address_r(MUX_READ_f),
        .data_w(w ? data_r : data_w),
        .data_r(data_r)
    );

    

    // Instantiate FSM for swap control
    swap_fsm FSM0 (
        .clk(clk),
        .reset_n(reset_n),
        .swap(swap),
        .w(w),
        .sel(sel)
    );

    // MUX to select READ address
    mux_4x1_nbit #(.N(ADDR_WIDTH)) MUX_READ (
        .w0(address_r),
        .w1(address_A),
        .w2(address_B),
        .w3('b0),
        .s(sel),
        .f(MUX_READ_f)
    );

    // MUX to select WRITE address
    mux_4x1_nbit #(.N(ADDR_WIDTH)) MUX_WRITE (
        .w0(address_w),
        .w1('b0),
        .w2(address_A),
        .w3(address_B),
        .s(sel),
        .f(MUX_WRITE_f)
    );

endmodule
