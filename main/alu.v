module alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);
        
    input [31:0] data_operandA, data_operandB;
    input [4:0] ctrl_ALUopcode, ctrl_shiftamt;

    output [31:0] data_result;
    output isNotEqual, isLessThan, overflow;

    wire [31:0] NOTdata_operandB, ApmB, selectB, bitwiseAND, bitwiseOR, leftShiftedA, rightShiftedA, dontCare;

    assign dontCare = 32'd0;
    bitwise_not BNOT(NOTdata_operandB, data_operandB);
    busmux_2 NCCB(selectB, ctrl_ALUopcode[0], data_operandB, NOTdata_operandB);

    carry_lookahead_adder ADDER(ApmB, overflow, isLessThan, isNotEqual, data_operandA, selectB, ctrl_ALUopcode[0]);
    logical_left_shifter LLS(leftShiftedA, ctrl_shiftamt, data_operandA);
    arithmetic_right_shifter ARS(rightShiftedA, ctrl_shiftamt, data_operandA);
    bitwise_and BWAND(bitwiseAND, data_operandA, data_operandB);
    bitwise_or BWOR(bitwiseOR, data_operandA, data_operandB);

    busmux_32 FINALSELECT(data_result, ctrl_ALUopcode, ApmB, ApmB, bitwiseAND, bitwiseOR, leftShiftedA, rightShiftedA, dontCare, dontCare, dontCare, dontCare, dontCare, dontCare, dontCare, dontCare, dontCare, dontCare, dontCare, dontCare, dontCare, dontCare, dontCare, dontCare, dontCare, dontCare, dontCare, dontCare, dontCare, dontCare, dontCare, dontCare, dontCare, dontCare);
endmodule