module Program_Counter (
    input  logic        clk,          
    input  logic        reset,        
    input  logic        pc_write,     // Write enable for PC
    input  logic [31:0] pc_next,      // Next PC value
    output logic [31:0] pc_current    // Current PC value
);

    always_ff @(posedge clk or posedge reset) begin
        if (reset) 
            pc_current <= 32'h00000000;  
        else if (pc_write) 
            pc_current <= pc_next;       
    end

endmodule
