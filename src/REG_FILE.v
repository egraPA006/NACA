module REG_FILE (
input link_jump,
input [4:0] reg1, // write back
input [4:0] reg2,
input [4:0] reg3,
output reg [31:0] data_reg2,
output reg [31:0] data_reg3,
input clk,
output reg [31:0] comp,
input [31:0] write_back,
input [31:0] mpc,
output reg [31:0] syscode,
input [31:0] keyboard,
output reg [31:0] datao_smem,
input [31:0] datai_smem,
output reg [31:0] addr_smem,
output reg [31:0] datao_gmem,
output reg [31:0] addr_gmem
);
/*
 Z-00000 0 constant zero
 t0-00001 1 
 t1-00010 2 
 t2-00011 3
 t3-00100 4
 t4-00101 5
 t5-00110 6
 sr-00111 7 datai sys mem
 sa-01000 8 addr sys mem
 sw-01001 9 datao sys mem
 ga-01010 10 addr g mem
 gw-01011 11 datao g mem
 sys-01100 12 syscode
 c-01101 13 compare
 mpc - 01110 14
 KEY - 01111 15 lastkeyboard
*/
reg [31:0] regs [31:0];
always @(posedge clk)
begin
	regs[0] <= 0;
    regs[reg1] <= write_back;
    data_reg2 <= regs[reg2];
    data_reg3 <= regs[reg3];
    if (link_jump) regs[14] <= mpc;
    datao_gmem <= regs[11];
    datao_smem <= regs[9];
    addr_gmem <= regs[10];
    addr_smem <= regs[8];
    syscode <= regs[12];
    comp <= regs[13];
    if (keyboard != 0) regs[15] <= keyboard;
    regs[7] <= datai_smem;
end
endmodule