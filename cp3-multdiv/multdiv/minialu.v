module minialu(data_result, data_operandA, data_operandB, ctrl_ALUopcode);
    input [31:0] data_operandA, data_operandB;
    input ctrl_ALUopcode;

    output [31:0] data_result;

    wire [31:0] NOTdata_operandB, cla_input;

    bitwise_not BNOT(NOTdata_operandB, data_operandB);
    busmux_2 NCCB(cla_input, ctrl_ALUopcode, data_operandB, NOTdata_operandB);

    minicla ADDER(data_result, data_operandA, cla_input, ctrl_ALUopcode);
endmodule