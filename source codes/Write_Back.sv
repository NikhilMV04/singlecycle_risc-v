module Write_Back (
    input  logic [31:0] alu_result,      
    input  logic [31:0] read_data,        // Data read from memory
    input  logic        mem_to_reg,      // Control signal to select memory or ALU result
    output logic [31:0] write_back_data  // Data to be written back to the register
);

    assign write_back_data = (mem_to_reg) ? read_data : alu_result;

endmodule
