module NACA (
input CLK_50,
output [3:0] VGA_R,
output [3:0] VGA_G,
output [3:0] VGA_B,
output VGA_HS,
output VGA_VS,
output reg LED
// some inputs from matrix keyboard
);
// IMEM and PC section (mostly)
reg RUN;
initial RUN = 1;
wire [31:0] write_back;
wire jump;
wire pc;
wire [31:0] command;
wire [4:0] opcode;
wire [4:0] reg1;
wire [4:0] reg2;
wire [4:0] reg3;
wire [15:0] immediate;
PC inst_1 (
.run (RUN),
.clk (CLK_50),
.dest (write_back),
.control (jump),
.pc (pc)
);
IMEM inst_2 (
.addr (pc),
.clk (CLK_50),
.data_o (command),
);
// parse output of IMEM
assign opcode = command[30:26];
assign reg1 = command[25:21];
assign reg2 = command[20:16];
assign reg3 = command[15:10];
assign immediate = command[15:0];
assign jump = command[31];

// CU section
wire immediate_c;
wire [3:0] ALU_op; // TODO: consider size of it?
wire ecall_c;
wire link_jump_c;
CU inst_4 (
.opcode (opcode),
.clk (CLK_50),
.immediate (immediate_c),
.ALU_op (ALU_op),
.ecall (ecall_c),
.link_jump (link_jump_c)
);
// register file section
wire [31:0] reg2_value;
wire [31:0] reg3_value;
wire [31:0] compare;
wire [31:0] syscode;
wire [31:0] keyboard;
wire [31:0] sys_mem_in;
wire [31:0] sys_mem_addr;
wire [31:0] sys_mem_out;
wire [31:0] g_mem_in;
wire [31:0] g_mem_addr;
REG_FILE inst_3 (
.link_jump (link_jump_c),
.reg1 (reg1), 
.reg2 (reg2),
.reg3 (reg3),
.data_reg2 (reg2_value),
.data_reg3 (reg3_value),
.clk (CLK_50),
.comp (compare),
.write_back (write_back),
.mpc (pc),
.syscode (syscode),
.keyboard (keyboard),
.datao_smem (sys_mem_in),
.datai_smem (sys_mem_out),
.addr_smem (sys_mem_addr),
.datao_gmem (g_mem_in),
.addr_gmem (g_mem_addr)
);
// multiplexer reg 3 or immediate value
reg [31:0] reg3_i;
always @(*)
begin
    if (immediate_c) reg3_i <= immediate;
    else reg3_i <= reg3_value;
end
// ALU
ALU inst_5 (
.opcode (ALU_op),
.reg2 (reg2_value),
.reg3 (reg3_i),
.write_back (write_back)
);
// ecall section
always @(*)
begin
    sys_mem_w <= 0;
    g_mem_w <= 0;
    if (ecall_c)
    begin
        case (syscode) 
            5'b00000: RUN <= 0;
            5'b00001: sys_mem_w <= 1;
            5'b00010: g_mem_w <= 1;
            5'b00011: LED <= 1;
            5'b00100: LED <= 0;
        endcase
    end
end


// sys mem
reg sys_mem_w;
initial
begin
    sys_mem_w = 0;
end
SMEM inst_6 (
.clk (CLK_50),
.addr (sys_mem_addr),
.data_i (sys_mem_in),
.data_o (sys_mem_out),
.we (sys_mem_w)
);

// graphic
wire g_data;
GCONSTMEM inst_8 (
.clk (CLK_50),
.instr (g_mem_in),
.data_o (g_data)
)
reg g_mem_w;
initial
begin
    g_mem_w = 0;
end
GPU inst_7 (
.instr (g_data),
.we (g_mem_w),
.addr (g_mem_addr),
.clk (CLK_50),
.VGA_R (VGA_R),
.VGA_B (VGA_B),
.VGA_G (VGA_G),
.v_sync (VGA_VS),
.h_sync (VGA_HS)
);



endmodule