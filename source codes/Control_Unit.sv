module Control_Unit (
    input  logic [6:0] opcode,      // Opcode from the instruction
    output logic       alu_src,     // ALU source (1: Immediate, 0: Register)
    output logic       mem_write,   // Memory write enable
    output logic       mem_read,    // Memory read enable
    output logic       mem_to_reg,  // Write-back source (1: Memory, 0: ALU)
    output logic       reg_write,   // Register file write enable
    output logic       branch,      // Branch signal for conditional jumps
    output logic [1:0] alu_op       // ALU operation type (for ALU_Control)
);

    // Decode control signals based on opcode
    always_comb begin
        // Default control signal values
        alu_src     = 1'b0;
        mem_write   = 1'b0;
        mem_read    = 1'b0;
        mem_to_reg  = 1'b0;
        reg_write   = 1'b0;
        branch      = 1'b0;
        alu_op      = 2'b00; // Default ALU operation

        case (opcode)
            7'b0110011: begin // R-type (e.g., ADD, SUB, AND, OR)
                alu_src    = 1'b0;  // Second ALU operand from register
                reg_write  = 1'b1;  // Write result to register
                alu_op     = 2'b10; // R-type ALU operations
            end
            7'b0010011: begin // I-type (e.g., ADDI)
                alu_src    = 1'b1;  // Second ALU operand is immediate
                reg_write  = 1'b1;  // Write result to register
                alu_op     = 2'b11; // I-type ALU operations
            end
            7'b0000011: begin // Load (e.g., LW)
                alu_src    = 1'b1;  // Second ALU operand is immediate
                mem_read   = 1'b1;  // Enable memory read
                mem_to_reg = 1'b1;  // Write data from memory to register
                reg_write  = 1'b1;  // Write result to register
                alu_op     = 2'b00; // ALU operation for address calculation
            end
            7'b0100011: begin // Store (e.g., SW)
                alu_src    = 1'b1;  // Second ALU operand is immediate
                mem_write  = 1'b1;  // Enable memory write
                alu_op     = 2'b00; // ALU operation for address calculation
            end
            7'b1100011: begin // B-type (e.g., BEQ, BNE)
                alu_src    = 1'b0;  // Second ALU operand from register
                branch     = 1'b1;  // Branch operation
                alu_op     = 2'b01; // B-type ALU operations (comparison)
            end
            7'b1101111: begin // J-type (JAL)
                reg_write  = 1'b1;  // Write return address to register
                alu_op     = 2'b00; // No ALU operation
            end
            7'b1100111: begin // I-type (JALR)
                alu_src    = 1'b1;  // Second ALU operand is immediate
                reg_write  = 1'b1;  // Write return address to register
                alu_op     = 2'b00; // No ALU operation
            end
            default: begin
                // Default case for unsupported or invalid opcodes
                alu_src     = 1'b0;
                mem_write   = 1'b0;
                mem_read    = 1'b0;
                mem_to_reg  = 1'b0;
                reg_write   = 1'b0;
                branch      = 1'b0;
                alu_op      = 2'b00; // Default operation
            end
        endcase
    end

endmodule
