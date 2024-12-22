module IMEM #(
parameter MEM_WIDTH = 1000
) (
input clk,
input [31:0] addr,
output [31:0] data_o,
input we
);
reg [31:0] mem [MEM_WIDTH-1:0];
reg [31:0] temp;
initial begin
	mem[0] = 32'b00000000000000000000000000000000;
end
always @(posedge clk)
begin
	temp <= mem[addr];
end
assign data_o = temp;
endmodule