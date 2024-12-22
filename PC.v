module PC (
input run,
input clk,
input [31:0] dest,
input control,
output reg [31:0] pc
);
reg [1:0] f;
initial
begin
	pc <= 0;
	f <= 0;
end
always @(posedge clk)
begin
	case (f)
		1'd0: f <= f + 1;
		1'd1: f <= f + 1;
		1'd2: begin
			if (control) pc <= dest & run;
			else pc <= (pc + 1) & run;
		f <= 0;
		end
	endcase
end
endmodule