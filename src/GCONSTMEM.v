module GCONSTMEM (
parameter MEM_WIDTH = 10
) (
input clk,
input [31:0] instr,
output [99:0] data_o,
input we
);
reg [99:0] mem [MEM_WIDTH-1:0];
reg [99:0] temp;
initial begin
	mem[0] = 100'b0000000000000011000000010010000010000100011111111001000000100100000010010000001001000000100000000000;
    mem[1] = 100'b0000000000011111100001000001000100000010011111111001000000100100000010010000001001111111100000000000;
end
always @(posedge clk)
begin
	temp <= mem[instr];
end
assign data_o = temp;
endmodule