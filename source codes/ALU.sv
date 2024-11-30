module ALU (
    input  logic [31:0] alu_input1,    // First operand
    input  logic [31:0] alu_input2,    // Second operand
    input  logic [3:0]  ALUControl,    // ALU control signal
    input  logic [2:0]  funct3,          // Fun3 field from instruction
    output logic [31:0] alu_result,    // ALU result
    output logic        zero_flag      // Zero flag
);

    always_comb begin
        case (ALUControl)
            4'b0000: alu_result = alu_input1 + alu_input2;  // ADD
            4'b0001: alu_result = alu_input1 - alu_input2;  // SUB
            4'b0010: alu_result = alu_input1 & alu_input2;  // AND
            4'b0011: alu_result = alu_input1 | alu_input2;  // OR
            4'b0100: alu_result = alu_input1 ^ alu_input2;  // XOR
            4'b0101: alu_result = alu_input1 << alu_input2; // Shift left
            4'b0110: alu_result = alu_input1 >> alu_input2; // Shift right (logical)
            4'b0111: alu_result = alu_input1 >>> alu_input2;// Shift right (arithmetic)
            4'b1000: alu_result = (alu_input1 < alu_input2) ? 32'b1 : 32'b0; // SLT
            default: alu_result = 32'b0;                       
        endcase
    end

    always_comb begin
        case (funct3)
            3'b000: zero_flag = (alu_result == 32'b0); // Zero flag for ADD
            3'b001: zero_flag = !(alu_result == 32'b0); // Zero flag for SUB
            3'b100: zero_flag = (alu_input1[31] > alu_input2[31]) ? 1'b1 : (alu_input1 < alu_input2); // Zero flag for SLT (signed)
            3'b101: zero_flag = (alu_input1[31] <= alu_input2[31]) ? 1'b0 : (alu_input1 >= alu_input2); // Zero flag for SLT (unsigned)
            3'b110: zero_flag = (alu_input1 < alu_input2); // Zero flag for SLT (unsigned)
            3'b111: zero_flag = (alu_input1 >= alu_input2); // Zero flag for SLT (unsigned)
            default: zero_flag = (alu_result == 32'b0); // Default zero flag logic
        endcase
    end

endmodule
