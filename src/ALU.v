module ALU (
    input [3:0] opcode,
    input signed [31:0] reg2,
    input signed [31:0] reg3,
    output reg signed [31:0] write_back
);
always @(*) 
begin
    case (opcode)
        4'b0000:b0000: write_back <= reg2 + reg3;
        4'b0001: write_back <= reg2 - reg3;
        4'b0010: write_back <= reg2 / reg3;
        4'b0011: write_back <= reg2 * reg3;
        4'b0100: write_back <= reg2 % reg3;
        4'b0101: write_back <= reg2 & reg3;
        4'b0110: write_back <= reg2 | reg3;
        4'b0111: write_back <= reg2 ^ reg3;
        4'b1000: write_back <= reg2;
        4'b1001: write_back <= reg2 << reg3;
        4'b1010: write_back <= reg2 >> reg3;
        4'b1011:
            begin
                if (reg2 > reg3) write_back <= 1;
                if (reg2 == reg3) write_back <= 0;
                if (reg2 < reg3) write_back <= -1;
            end
    endcase
end
endmodule