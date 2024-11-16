module Memory_Access_Control(
    input logic clk,reset,
    input logic [2:0]funct3,
    input logic [6:0]opcode,
    output logic [2:0]control_logic
);

always_ff @ (posedge clk or posedge reset) begin
    if(reset)
        control_logic <= 3'b0;
    else    
        if(opcode==0000011) begin
            if(funct3==000)
                control_logic <= 3'b000;
            else if(funct3==001)
                control_logic <= 3'b001;
            else if(funct3==010)
                control_logic <= 3'b010;
            else if(funct3==100)
                control_logic <= 3'b011;
            else if(funct3==101)
                control_logic <= 3'b100;
        end
        else if(opcode==0100011) begin
            if(funct3==000)
                control_logic <= 3'b101;
            else if(funct3==001)
                control_logic <= 3'b110;
            else if(funct3==010)
                control_logic <= 3'b111;
        end
end

endmodule