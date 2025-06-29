module mux_4x1_nbit #(parameter N = 3) (
    input [N-1:0] w0, w1, w2, w3,
    input [1:0] s,
    output reg [N-1:0] f
);

always @(w0, w1, w2, w3,s) 
begin
    f = 'bx;
    case (s)
        2'b00: f = w0;
        2'b01: f = w1;
        2'b10: f = w2;
        2'b11: f = w3;
        default: f = 'bx; // undefined if s is not 2 bits
    endcase
end

endmodule
