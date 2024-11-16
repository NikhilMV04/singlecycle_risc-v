module TopModule (
    input  logic        clk,
    input  logic        reset
);
    // Internal signals
    logic [31:0] pc_current, pc_next, instruction;
    logic [31:0] rs1_data, rs2_data, imm_value;
    logic [31:0] alu_result, read_data, write_back_data;
    logic [31:0] adder_out, adder1_out;
    logic [31:0] shifted_immvalue;
    logic [4:0]  rs1_addr, rs2_addr, rd_addr;
    logic [6:0]  opcode;
    logic [2:0]  funct3;
    logic [6:0]  funct7;
    logic        alu_src, mem_write, mem_read, mem_to_reg, reg_write, branch;
    logic [1:0]  alu_op;
    logic [3:0] ALUControl;
    logic       zero_flag;
    logic        pc_src;
    logic        is_imm;
    logic        write_data;

    topmodule_fetch if_stage (
        .clk(clk),
        .reset(reset),
        .pc_next(pc_next),
        .pc_current(pc_current),
        .instruction(instruction),
        .adder_out(adder_out)
    );

    Top_IDecode decoder (
        .reset(reset),
        .instruction(instruction),
        .rs1_data(rs1_data),
        .rs2_data(rs2_data),
        .reg_write(reg_write),
        .funct3(funct3),
        .funct7(funct7),
        .imm_value(imm_value),
        .write_back_data(write_back_data),
        .opcode(opcode)
        
    );

    Control_Unit control (
        .opcode(opcode),
        .alu_src(alu_src),
        .mem_write(mem_write),
        .mem_read(mem_read),
        .mem_to_reg(mem_to_reg),
        .reg_write(reg_write),
        .branch(branch),
        .alu_op(alu_op)
    );


    assign funct3 = instruction[14:12];
    assign funct7 = instruction[31:25];

    Top_IExecute ie_stage (
        .rs1_data(rs1_data),
        .rs2_data(rs2_data),
        .imm_value(imm_value),
        .pc_current(pc_current),
        .funct3(funct3),
        .funct7(funct7),
        .alu_src(alu_src),
        .alu_op(alu_op),
        .alu_result(alu_result),
        .zero_flag(zero_flag)
    );

    // Branch handling components
    shift_left shifter (
        .imm_value(imm_value),
        .shifted_immvalue(shifted_immvalue)
    );

    adder_alu1 branch_adder (
        .pc_current(pc_current),
        .shifted_immvalue(shifted_immvalue),
        .adder1_out(adder1_out)
    );

    and_branch branch_control (
        .zeroflag(zero_flag),
        .branch(branch),
        .pc_src(pc_src)
    );

    mux3 pc_next_mux (
        .adder_out(adder_out),
        .adder1_out(adder1_out),
        .pc_src(pc_src),
        .pc_next(pc_next)
    );

    Top_MemAccess mem_stage (
        .mem_write(mem_write),
        .mem_read(mem_read),
        .alu_result(alu_result),
        .write_data(rs2_data),
        .clk(clk),
        .reset(reset),
        .funct3(funct3),
        .opcode(opcode),
        .read_data(read_data)
    );

    Top_WriteBack wb_stage (
        .alu_result(alu_result),
        .read_data(read_data),
        .mem_to_reg(mem_to_reg),
        .write_back_data(write_back_data)
    );

endmodule