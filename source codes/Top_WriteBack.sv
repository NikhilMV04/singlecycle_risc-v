module Top_WriteBack (
    input  logic [31:0] alu_result,
    input  logic [31:0] read_data,
    input  logic        mem_to_reg,
    output logic [31:0] write_back_data
);
    Write_Back wb_mux (
        .alu_result(alu_result),
        .read_data(read_data),
        .mem_to_reg(mem_to_reg),
        .write_back_data(write_back_data)
    );
endmodule