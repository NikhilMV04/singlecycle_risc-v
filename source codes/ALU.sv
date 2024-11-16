module ALU (
    input  logic [31:0] alu_input1,    
    input  logic [31:0] alu_input2,    
    input  logic [3:0]  ALUControl,        
    output logic [31:0] alu_result,    
    output logic        zero_flag      
);

    always_comb begin
        case (ALUControl)
            4'b0010: alu_result = alu_input1 + alu_input2;  
            4'b0110: alu_result = alu_input1 - alu_input2;  
            4'b0000: alu_result = alu_input1 & alu_input2;  
            4'b0001: alu_result = alu_input1 | alu_input2;  
            default: alu_result = 32'b0;                    
        endcase
    end

    assign zero_flag = (alu_result == 32'b0);

endmodule
