module mux3(
    input logic [31:0] adder_out,
    input logic [31:0] adder1_out,
    input logic pc_src,
    output logic [31:0] pc_next
    );
        assign pc_next = (pc_src == 1'b0) ? adder1_out : adder_out;

endmodule
