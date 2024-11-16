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
    // Decode fields from the instruction
    assign rs1_addr = instruction[19:15];
    assign rs2_addr = instruction[24:20];
    assign rd_addr  = instruction[11:7];
    assign opcode   = instruction[6:0];
    assign funct3   = instruction[14:12];  // Added funct3 extraction
    assign funct7   = instruction[31:25];  // Added funct7 extraction
    
    // Determine if instruction uses an immediate value (I-type, S-type, B-type)
    assign is_imm = (opcode == 7'b0010011 || opcode == 7'b0000011 || opcode == 7'b0100011);
endmodule
