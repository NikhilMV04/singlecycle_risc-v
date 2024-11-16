module Top_IExecute (
    input  logic [31:0] rs1_data,
    input  logic [31:0] rs2_data,
    input  logic [31:0] imm_value,
    input  logic [31:0] pc_current,
    input  logic [2:0]  funct3,
    input  logic [6:0]  funct7,
    input  logic        alu_src,
    input  logic [1:0]  alu_op,
    output logic [31:0] alu_result,
    output logic        zero_flag
);
    // Internal signals
    logic [3:0]  ALUControl;
    logic [31:0] alu_input1;
    logic [31:0] alu_input2;

    ALU_Control alu_ctrl (
        .alu_op(alu_op),
        .funct3(funct3),
        .funct7(funct7),
        .ALUControl(ALUControl)
    );

    ALU_MUX2 alu_mux1 (
        .pc_current(pc_current),
        .rs1_data(rs1_data),
        .sel(1'b1),          // Select register data
        .alu_input_1(alu_input1)
    );

    ALU_MUX alu_mux2 (
        .rs2_data(rs2_data),
        .imm_value(imm_value),
        .alu_src(alu_src),
        .alu_input2(alu_input2)
    );

    ALU alu_unit (
        .alu_input1(alu_input1),
        .alu_input2(alu_input2),
        .ALUControl(ALUControl),
        .alu_result(alu_result),
        .zero_flag(zero_flag)
    );
endmodule