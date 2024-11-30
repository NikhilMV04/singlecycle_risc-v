module Imm_Block (
    input  logic [31:0] instruction,   // Full instruction
    input  logic [6:0]  opcode,        // Opcode decoded by Decoder_ID
    output logic [31:0] imm_value      // Calculated immediate value
);

    always_comb begin
        // Default value for imm_value
        imm_value = 32'd0;

        // Decode based on opcode
        case (opcode)
            7'b0010011, 7'b0000011: begin // I-type instructions (e.g., ADDI, LOAD)
                imm_value = {{20{instruction[31]}}, instruction[31:20]}; // Sign extend 12-bit immediate
            end

            7'b0100011: begin // S-type instructions (e.g., STORE)
                imm_value = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]}; // Sign extend 12-bit immediate
            end

            7'b1100011: begin // B-type instructions (e.g., BEQ, BNE)
                imm_value = {{19{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0}; // Sign extend and shift
            end

            7'b1101111: begin // J-type instructions (e.g., JAL)
                imm_value = {{11{instruction[31]}}, instruction[31], instruction[19:12], instruction[20], instruction[30:21], 1'b0}; // Sign extend and shift
            end

            7'b1100111: begin // I-type JALR instruction
                imm_value = {{20{instruction[31]}}, instruction[31:20]}; // Same as I-type
            end

            default: imm_value = 32'd0; // Default to zero for unsupported instructions
        endcase
    end

endmodule
