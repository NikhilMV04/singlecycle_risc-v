module Top_MemAccess (
    input  logic        mem_write,
    input  logic        mem_read,
    input logic         clk,reset,
    input logic [2:0]   funct3,
    input logic [6:0]   opcode,
    input  logic [31:0] alu_result,
    input  logic [31:0] write_data,
    output logic [31:0] read_data
);
    logic [2:0]control_logic;
    
    Data_Memory dmem (
        .mem_write(mem_write),
        .mem_read(mem_read),
        .alu_result(alu_result),
        .write_data(write_data),
        .read_data(read_data),
        .control_logic(control_logic)
    );
    
    Memory_Access_Control memcontrol (
        .clk(clk),
        .reset(reset),
        .funct3(funct3),
        .opcode(opcode),
        .control_logic(control_logic)
        );
          
endmodule