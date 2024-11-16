module Data_Memory ( 
    input [2:0] control_logic,
    input logic [31:0] alu_result,        
    input logic mem_read, mem_write,      
    input logic [31:0] write_data,        
    output logic [31:0] read_data         
);

    logic [31:0] data_mem[1023:0];  // Memory array (1 KB)

    always_comb begin
        if (mem_read) begin
            case (control_logic)
                3'b000: read_data = {{24{data_mem[alu_result][7]}}, data_mem[alu_result][7:0]};   // Load signed byte (sign-extend)
                3'b011: read_data = {24'b0, data_mem[alu_result][7:0]};                           // Load unsigned byte (zero-extend)
                3'b001: read_data = {{16{data_mem[alu_result][15]}}, data_mem[alu_result][15:0]}; // Load signed halfword (sign-extend)
                3'b100: read_data = {16'b0, data_mem[alu_result][15:0]};                          // Load unsigned halfword (zero-extend)
                3'b010: read_data = {data_mem[alu_result+3], data_mem[alu_result+2], 
                                     data_mem[alu_result+1], data_mem[alu_result]};               // Load full word
                default: read_data = 32'b0;
            endcase
        end
        else if (mem_write) begin
            case (control_logic)
                3'b101: data_mem[alu_result][7:0] = write_data[7:0];                              // Store byte
                3'b110: begin                                                                     // Store halfword
                    data_mem[alu_result][7:0]   = write_data[7:0];
                    data_mem[alu_result+1][7:0] = write_data[15:8];
                end
                3'b111: begin                                                                     // Store word
                    data_mem[alu_result][7:0]   = write_data[7:0];
                    data_mem[alu_result+1][7:0] = write_data[15:8];
                    data_mem[alu_result+2][7:0] = write_data[23:16];
                    data_mem[alu_result+3][7:0] = write_data[31:24];
                end
            endcase
        end
        else begin
            read_data = 32'b0;
        end
    end

endmodule
