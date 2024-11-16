module Reg_File (
    input logic         reset,
    input  logic        reg_write,     // Register write enable
    input  logic [4:0]  rs1_addr,      // Source register 1 address
    input  logic [4:0]  rs2_addr,      // Source register 2 address
    input  logic [4:0]  rd_addr,       // Destination register address
    input  logic [31:0] rd_data,       // Data to write to destination register
    output logic [31:0] rs1_data,      // Data from source register 1
    output logic [31:0] rs2_data       // Data from source register 2
);

    // 32 registers (x0 - x31)
    logic [31:0] registers [31:0];

    // Read registers
    assign rs1_data = registers[rs1_addr];
    assign rs2_data = registers[rs2_addr];

    // Write to destination register immediately if enabled and rd_addr is not x0
    always_ff@(posedge reg_write or posedge reset) begin
    if (reset) begin
            for (int i = 0; i < 32; i++)
                registers[i] <= 32'b0;
        end 

         else if (rd_addr != 5'b0) begin
            registers[rd_addr] <= rd_data;  // Write data to register
        end
    end


endmodule
