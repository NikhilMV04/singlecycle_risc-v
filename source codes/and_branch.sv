module and_branch(
    input logic zeroflag,
    input logic branch,
    output logic pc_src
    );
    assign pc_src= zeroflag&branch;
endmodule
