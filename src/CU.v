module CU (
    input [5:0] opcode,
    input clk,
    output reg immediate,
    output reg [3:0] ALU_op,
    output reg ecall,
    output reg link_jump
);
always @(posedge clk)
begin
    case (opcode)
        6'b000000: begin
            immediate <= 1'b0;
            ecall <= 1'b0;
            link_jump <= 1'b0;
        end
        6'b000001: begin
            immediate <= 1'b1;
            ecall <= 1'b0;
            link_jump <= 1'b0;
            ALU_op <= 4'b0000;
        end
        6'b000010: begin
            immediate <= 1'b0;
            ecall <= 1'b0;
            link_jump <= 1'b0;
            ALU_op <= 4'b0000;
        end
        6'b000011: begin
            immediate <= 1'b0;
            ecall <= 1'b0;
            link_jump <= 1'b0;
            ALU_op <= 4'b0001;;
        end
        6'b000100: begin
            immediate <= 1'b0;
            ecall <= 1'b0;
            link_jump <= 1'b0;
            ALU_op <= 4'b0010;;
        end
        6'b000101: begin
            immediate <= 1'b0;
            ecall <= 1'b0;
            link_jump <= 1'b0;
            ALU_op <= 4'b0011;
        end
        6'b000110: begin
            immediate <= 1'b0;
            ecall <= 1'b0;
            link_jump <= 1'b0;
            ALU_op <= 4'b0100;
        end
        6'b000111: begin
            immediate <= 1'b0;
            ecall <= 1'b0;
            link_jump <= 1'b0;
            ALU_op <= 4'b0101;
        end
        6'b001000: begin
            immediate <= 1'b0;
            ecall <= 1'b0;
            link_jump <= 1'b0;
            ALU_op <= 4'b0110;
        end
        6'b001001: begin
            immediate <= 1'b0;
            ecall <= 1'b0;
            link_jump <= 1'b0;
            ALU_op <= 4'b0111;
        end
        6'b001010: begin
            immediate <= 1'b0;
            ecall <= 1'b0;
            link_jump <= 1'b0;
            ALU_op <= 4'b1000;
        end
        6'b001011: begin
            immediate <= 1'b0;
            ecall <= 1'b0;
            link_jump <= 1'b0;
            ALU_op <= 4'b1000;
        end
        6'b001100: begin
            immediate <= 1'b0;
            ecall <= 1'b0;
            link_jump <= 1'b0;
            ALU_op <= 4'b1000;
        end
        6'b001101: begin
            immediate <= 1'b0;
            ecall <= 1'b0;
            link_jump <= 1'b0;
            ALU_op <= 4'b1000;
        end
        6'b001110: begin
            immediate <= 1'b0;
            ecall <= 1'b0;
            link_jump <= 1'b0;
            ALU_op <= 4'b1000;
        end
        6'b001111: begin
            immediate <= 1'b0;
            ecall <= 1'b0;
            link_jump <= 1'b1;
            ALU_op <= 4'b1000;
        end
        6'b010000: begin
            immediate <= 1'b0;
            ecall <= 1'b0;
            link_jump <= 1'b1;
            ALU_op <= 4'b1000;
        end
        6'b010001: begin
            immediate <= 1'b0;
            ecall <= 1'b0;
            link_jump <= 1'b1;
            ALU_op <= 4'b1000;
        end
        6'b010010: begin
            immediate <= 1'b0;
            ecall <= 1'b0;
            link_jump <= 1'b1;
            ALU_op <= 4'b1000;
        end
        6'b010011: begin
            immediate <= 1'b0;
            ecall <= 1'b0;
            link_jump <= 1'b1;
            ALU_op <= 4'b1000;
        end
        6'b010100: begin
            immediate <= 1'b0;
            ecall <= 1'b0;
            link_jump <= 1'b0;
            ALU_op <= 4'b1001;
        end
        6'b010101: begin
            immediate <= 1'b0;
            ecall <= 1'b0;
            link_jump <= 1'b0;
            ALU_op <= 4'b1010;
        end
        6'b010110: begin
            immediate <= 1'b0;
            ecall <= 1'b0;
            link_jump <= 1'b0;
            ALU_op <= 4'b1011;
        end
        6'b010111: begin
            immediate <= 1'b0;
            ecall <= 1'b1;
            link_jump <= 1'b0;
			end
    endcase
end
endmodule