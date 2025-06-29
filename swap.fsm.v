module swap_fsm (
    input clk,
    input reset_n,
    input swap,
    output  w,
    output  [1:0] sel
);

    
   

    reg [1:0] state_reg, state_next;
    parameter S0 = 0,
              S1 = 1,
              S2 = 2,
              S3 = 3;


    // Sequential state register update
    always @(posedge clk , negedge reset_n) begin
        if (~reset_n)
            state_reg <= S0;
        else
            state_reg <= state_next;
    end

    // Next state logic
    always @(*)
     begin
        state_next = state_reg;
        case (state_reg)
            S0: begin
                if (~swap)
                    state_next = S0;
                else
                    state_next = S1;
            end
            S1: state_next = S2;
            S2: state_next = S3;
            S3: state_next = S0;
            default: state_next = S0;
        endcase
    end

    // Output logic
    assign sel = state_reg;
    assign w = (state_reg != S0);

endmodule
