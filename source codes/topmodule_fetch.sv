// 1. Instruction Fetch (IF) Stage
module topmodule_fetch (
    input  logic        clk,
    input  logic        reset,
    input  logic [31:0] pc_next,
    output logic [31:0] pc_current,
    output logic [31:0] instruction,
    output logic [31:0] adder_out
);

    
    Program_Counter pc (
        .clk(clk),
        .reset(reset),
        .pc_next(pc_next),
        .pc_current(pc_current)
    );

    adder_alu pc_adder (
        .pc_current(pc_current),
        .adder_out(adder_out)
    );


    Instruction_Memory imem (
        .pc_current(pc_current),
        .instruction(instruction)
    );
endmodule