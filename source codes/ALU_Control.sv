    module ALU_Control (
        input  logic [1:0] alu_op,         
        input  logic [2:0] funct3,         
        input  logic [6:0] funct7,         
        output logic [3:0] ALUControl          
    );
    
        always_comb begin
        // Default ALU control signal
        ALUControl = 4'b0000;  // NOP or no operation
        
        case (alu_op)
            2'b00: begin  // Load/Store
                ALUControl = 4'b0010;  // ADD
            end
            2'b01: begin  // Branch
                ALUControl = 4'b0110;  // SUB
            end
            
            2'b10: begin  // R-type
                case (funct3)
                    3'b000: begin
                        if (funct7 == 7'b0000000)
                            ALUControl = 4'b0010;  // ADD
                        else if (funct7 == 7'b0100000)
                            ALUControl = 4'b0110;  // SUB
                    end
                    3'b111: ALUControl = 4'b0000;  // AND
                    3'b110: ALUControl = 4'b0001;  // OR
                    3'b100: ALUControl = 4'b0011;  // XOR
                    3'b001: ALUControl = 4'b0101;  // SLL (Shift Left Logical)
                    3'b101: begin
                        if (funct7 == 7'b0000000)
                            ALUControl = 4'b1101;  // SRL (Shift Right Logical)
                        else if (funct7 == 7'b0100000)
                            ALUControl = 4'b1111;  // SRA (Shift Right Arithmetic)
                    end
                endcase
            end
        endcase
    end
endmodule