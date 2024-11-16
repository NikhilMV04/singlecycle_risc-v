module ALU_MUX2 (
    input  logic [31:0] pc_current,    
    input  logic [31:0] rs1_data,      
    input  logic        sel,           
    output logic [31:0] alu_input_1    
);

    assign alu_input_1 = (sel == 1'b0) ? pc_current : rs1_data;

endmodule
