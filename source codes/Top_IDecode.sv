module Top_IDecode (
    input logic         reset,
    input  logic        reg_write,
    input  logic [31:0] instruction,
    input  logic [31:0] write_back_data,
    output logic [31:0] imm_value,
    output logic [6:0]  opcode,
    output logic [2:0]  funct3,
    output logic [6:0]  funct7,
    output logic        alu_src,
    output logic        mem_write,
    output logic        mem_read,
    output logic        mem_to_reg,
    output logic        branch,
    output logic [1:0]  alu_op,
    output logic [31:0] rs1_data,      
    output logic [31:0] rs2_data       
);
    // Internal signals
    logic [4:0] rs1_addr, rs2_addr, rd_addr;

    Decoder_ID decoder (
        .instruction(instruction),
        .rs1_addr(rs1_addr),
        .rs2_addr(rs2_addr),
        .rd_addr(rd_addr),
        .funct3(funct3),
        .funct7(funct7),
        .opcode(opcode),
        .is_imm()  // Not used in control
    );


    Reg_File regfile (
        .reset(reset),
        .reg_write(reg_write),
        .rs1_addr(rs1_addr),
        .rs2_addr(rs2_addr),
        .rd_addr(rd_addr),
        .rd_data(write_back_data),
        .rs1_data(rs1_data),
        .rs2_data(rs2_data)
    );

    Imm_Block imm_gen (
        .instruction(instruction),
        .opcode(opcode),
        .imm_value(imm_value)
    );


endmodule