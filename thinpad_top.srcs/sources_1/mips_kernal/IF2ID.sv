module IF2ID (
    input logic clk,
    input logic rst,
    input logic [31:0]  PC_Inter,
    output logic [31:0] I_PC
);

    always_ff @(posedge clk) begin
		if(rst) begin
			I_PC <= 0;
		end
		else begin
			I_PC <= PC_Inter;
		end
    end

endmodule