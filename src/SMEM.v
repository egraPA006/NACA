module SMEM #(
parameter MEM_WIDTH = 1000
) (
input clk,
input [31:0] addr,
output [31:0] data_o,
input [31:0] data_i,
input we
);
reg [31:0] mem [MEM_WIDTH-1:0];
reg [31:0] temp;
always @(posedge clk)
begin
	if (we)
	begin
		mem[addr] <= data_i;
	end
    if (!we) temp <= mem[addr];

end
assign data_o = temp;
endmodule