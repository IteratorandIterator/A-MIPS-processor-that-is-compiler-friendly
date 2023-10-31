module WriteBack (
    input logic clk,
    input logic rst,

    input logic WB_IN1,
    input logic [4:0] WB_IN2,
    input logic [31:0] WB_IN3,

    output logic WB_OUT1,
    output logic [4:0] WB_OUT2,
    output logic [31:0] WB_OUT3
);

    always_ff @(posedge clk) begin
		if(rst) begin
			WB_OUT1 <= 0;
			WB_OUT2 <= 0;
			WB_OUT3 <= 0;
		end
		else begin
			WB_OUT1 <= WB_IN1;
			WB_OUT2 <= WB_IN2;
			WB_OUT3 <= WB_IN3;
		end
    end

endmodule