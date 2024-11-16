module ALU_MUX (
    input  logic [31:0] rs2_data,      
    input  logic [31:0] imm_value,     
    input  logic        alu_src,       
    output logic [31:0] alu_input2     
);

    assign alu_input2 = (alu_src == 1'b0) ? rs2_data : imm_value;

endmodule
