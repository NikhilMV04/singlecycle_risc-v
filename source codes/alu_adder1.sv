module adder_alu1 (
    input  logic [31:0] pc_current, 
    input  logic [31:0] shifted_immvalue,
    output logic [31:0] adder1_out     
);

   
    assign adder1_out = pc_current + shifted_immvalue ;

endmodule
