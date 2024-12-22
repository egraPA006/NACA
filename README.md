# NACA
![Project Status](https://img.shields.io/badge/project_status-abandoned-yellow.svg)
## Brief story
**NACA** (not another computer architecture) is my 2023-2024 winter project that was inspired by computer architecture course at Innopolis University during
1st year of study. I tried to design my own *RISC* architecture with it's own instruction set and implement a processor in Verilog to run on FPGA board. 
The planning went smooth, however I didn't have time to finish the implementation, so the current state of the project is in the begining of implementation without any recent development.
## Architecture design
### Registers
NACA has 16 integer "general" purpose 32-bit registers
|Register code |Register name |Register shortname |
| --- | --- | ---|
| 0 | zero register | z | 
1 | general purpose | t0 |
2 | general purpose | t1 |
3 | general purpose | t2 |
4 | general purpose | t3 |
5 | general purpose | t4 |
6 | general purpose | t5 |
7 | system memory read | sr |
8 | system memory address | sa |
9 | system memory write | sw |
10 | graphic memory address | ga |
11 | graphic memory write | gw |
12 | system code | sys |
13 | compare register | cmp |
14 | memory for program counter | mpc |
15 | last keyboard input | key |

### Instruction set
Each instruction is 32-bit. There are 4 types of instructions, and here are their bit representations:

#### Register Ops:

| jump | opcode | dist_reg | a_reg | b_reg | zeros    |
|-------|--------|----------|-------|-------|----------|
| 0 | 5-bit  | 5-bit    | 5-bit | 5-bit | 11-bit   |

#### Immediate Ops:

| jump | opcode | dist_reg | a_reg | immediate_value |
|------|--------|----------|-------|------------------|
| 0| 5-bit  | 5-bit    | 5-bit | 16-bit           |

#### Jump Instr:

| jump | opcode | to_instr_addr | from_instr_adr | zeros    |
|------|--------|----------------|-----------------|----------|
| 1| 5-bit  | 12-bit         | 12-bit          | 15-bit   |

#### Ecall (Operates with Register SYS CALL):

| jump | opcode | zeros       |
|------|--------|--------------|
|0 | 5-bit  | 25-bit       |


Also since there are some instructions that have similar logic in ALU module, the table below contains also the code for ALU for each instruction:
| Opcode | Instruction | Operands                     | Type               | ALU Code | Description                        |
|--------|-------------|------------------------------|--------------------|----------|-------------------------------------|
| 00000  | nop         |                              | Skip Cycle         | 00000    | Skip cycle                          |
| 00001  | addi        | reg1, reg2, const (16-bit)   | Immediate Op       | 000      | Add constant to register            |
| 00010  | add         | reg1, reg2, reg3             | Register Op        | 000      | Sum two registers                   |
| 00011  | sub         | reg1, reg2, reg3             | Register Op        | 001      | Subtract one register from another  |
| 00100  | div         | reg1, reg2, reg3             | Register Op        | 010      | Divide one register by another      |
| 00101  | mul         | reg1, reg2, reg3             | Register Op        | 011      | Multiply two registers              |
| 00110  | rem         | reg1, reg2, reg3             | Register Op        | 100      | Remainder of division               |
| 00111  | and         | reg1, reg2, reg3             | Bitwise Operation  | 101      | Bitwise AND                         |
| 01000  | or          | reg1, reg2, reg3             | Bitwise Operation  | 110      | Bitwise OR                          |
| 01001  | xor         | reg1, reg2, reg3             | Bitwise Operation  | 111      | Bitwise XOR                         |
| 01010  | jil         | reg                          | Conditional Jump   | 1000     | Jump if C == -1                     |
| 01011  | jig         | reg                          | Conditional Jump   | 1000     | Jump if C == 1                      |
| 01100  | jie         | reg                          | Conditional Jump   | 1000     | Jump if C == 0                      |
| 01101  | jin         | reg                          | Conditional Jump   | 1000     | Jump if C != 0                      |
| 01110  | jmp         | reg                          | Unconditional Jump | 1000     | Unconditional jump                  |
| 01111  | jill        | reg1, reg2                   | Link Jump          | 1000     | Jump and save return address        |
| 10000  | jigl        | reg1, reg2                   | Link Jump          | 1000     | Similar to jill                     |
| 10001  | jinl        | reg1, reg2                   | Link Jump          | 1000     | Similar to jill                     |
| 10010  | jiel        | reg1, reg2                   | Link Jump          | 1000     | Similar to jill                     |
| 10011  | jmpl        | reg1, reg2                   | Link Jump          | 1000     | Similar to jill                     |
| 10100  | sl          | reg1, reg2, reg3             | Shift Left         | 1001     | Shift left                          |
| 10101  | sr          | reg1, reg2, reg3             | Shift Right        | 1010     | Shift right                         |
| 10110  | cmp         | reg1, reg2                   | Compare            | 1011     | Compare registers                   |
| 10111  | ecall       |                              | System Call        | ?        | System call (ALU code unknown)      |

(Some numbers maybe be incorrect, so this for sure is __FIXME:__)

### System calls
_ecall_ instructions executes the system call that is in SYS register. System calls table:

| SYS Data | Description           |
|----------|-----------------------|
| 0        | Exit                  |
| 1        | Write to system memory|
| 2        | Write to GPU          |
| 3        | Error (LED goes ON)   |
| 4        | Error down (LED goes OFF)|

### General scheme

![alt text](images/scheme.png "Title")
## Technological stack
- Verilog
- Quartus prime lite
- De10-Lite MAX 10 FPGA Board