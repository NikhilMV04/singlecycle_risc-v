module Instruction_Memory (
    input  logic [31:0] pc_current,      
    output logic [31:0] instruction   
);

    logic [31:0] memory [0:255];      

    initial begin
        // Initialize memory with some instructions
        memory[0] = 32'h00100093;  // addi x1, x0, 1       ; x1 = x0 + 1
        memory[1] = 32'h00200113;  // addi x2, x0, 2       ; x2 = x0 + 2
        memory[2] = 32'h00308193;  // addi x3, x1, 3       ; x3 = x1 + 3
        memory[3] = 32'h00408213;  // addi x4, x1, 4       ; x4 = x1 + 4
        memory[4] = 32'h00510293;  // addi x5, x2, 5       ; x5 = x2 + 5
        memory[5] = 32'h00618313;  // addi x6, x3, 6       ; x6 = x3 + 6
        memory[6] = 32'h00720393;  // addi x7, x4, 7       ; x7 = x4 + 7
        memory[7] = 32'h00a20223;  // sw x10, 0(x4)        ; store x10 at address x4 + 0
        memory[8] = 32'h00028283;  // lw x5, 0(x5)         ; load word at address x5 into x5
        memory[9] = 32'h0080006f;  // jal x1, 8            ; jump to PC + 8 and set x1 to return address
        memory[10] = 32'h00140463; // beq x8, x1, 4        ; if x8 == x1, branch by 4 instructions
        memory[11] = 32'h00208433; // add x8, x1, x2       ; x8 = x1 + x2
    end

    // Fetch the instruction at the address
    assign instruction = memory[pc_current[9:2]];  // PC divided by 4 to address word locations

endmodule
