module shift_left(
    input logic [31:0] imm_value,
    output logic [31:0] shifted_immvalue
    );
    assign shifted_immvalue=imm_value<<1;
endmodule
