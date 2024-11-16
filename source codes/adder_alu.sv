module adder_alu (
    input  logic [31:0] pc_current,    // Current PC value
    output logic [31:0] adder_out      // Output: PC + increment
);

    // Simple addition for PC
    assign adder_out = pc_current + 4 ;

endmodule
