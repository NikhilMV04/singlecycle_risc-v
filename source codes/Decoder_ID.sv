module Decoder_ID (
    input  logic [31:0] instruction,  // Fetched instruction
    output logic [4:0]  rs1_addr,     // Source register 1 address
    output logic [4:0]  rs2_addr,     // Source register 2 address
    output logic [4:0]  rd_addr,      // Destination register address
    output logic [6:0]  opcode,       // Opcode of the instruction
    output logic [2:0]  funct3,       // Function 3 field
    output logic [6:0]  funct7,       // Function 7 field
    output logic        is_imm        // Flag indicating if instruction uses an immediate value
);
    always_comb begin
        // Initialize all outputs
        rs1_addr = 5'b0;
        rs2_addr = 5'b0;
        rd_addr  = 5'b0;
        funct3   = 3'b0;
        funct7   = 7'b0;
        opcode   = instruction[6:0];

        // Decode based on opcode
        case (opcode)
            7'b0110011: begin // R-type
                rd_addr  = instruction[11:7];
                funct3   = instruction[14:12];
                rs1_addr = instruction[19:15];
                rs2_addr = instruction[24:20];
                funct7   = instruction[31:25];
            end
            7'b0010011: begin // I-type except jalr and load
                rd_addr  = instruction[11:7];
                funct3   = instruction[14:12];
                rs1_addr = instruction[19:15];
            end
            7'b0000011: begin // Load (I-type)
                rd_addr  = instruction[11:7];
                funct3   = instruction[14:12];
                rs1_addr = instruction[19:15];
            end
            7'b1100111: begin // JALR (I-type)
                rd_addr  = instruction[11:7];
                funct3   = instruction[14:12];
                rs1_addr = instruction[19:15];
            end
            7'b1100011: begin // B-type (Branch)
                funct3   = instruction[14:12];
                rs1_addr = instruction[19:15];
                rs2_addr = instruction[24:20];
            end
            7'b0100011: begin // S-type (Store)
                funct3   = instruction[14:12];
                rs1_addr = instruction[19:15];
                rs2_addr = instruction[24:20];
            end
            7'b0110111, 7'b0010111: begin // U-type (LUI/AUIPC)
                rd_addr  = instruction[11:7];
            end
            7'b1101111: begin // J-type (JAL)
                rd_addr  = instruction[11:7];
            end
            default: begin
                // Handle default case if needed
            end
        endcase

        // Check if instruction uses an immediate value (I-type, S-type, B-type)
        is_imm = (opcode == 7'b0010011 || opcode == 7'b0000011 || opcode == 7'b0100011 || opcode == 7'b1100011 || opcode == 7'b1101111 || opcode == 7'b1100111);
    end
endmodule
