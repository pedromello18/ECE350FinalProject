`timescale 1 ns/100 ps
module aludebugging_tb;
    wire [31:0] data_operandA, data_operandB, data_result;
    wire [4:0] ctrl_ALUopcode, ctrl_shiftamt;
    wire isNotEqual, isLessThan, overflow;

    assign data_operandA = 32'd3;
    assign data_operandB = 32'd1;
    assign ctrl_ALUopcode = 5'b00010;
    assign ctrl_shiftamt = 5'b00000;

    alu TEST(.data_operandA(data_operandA), .data_operandB(data_operandB), .ctrl_ALUopcode(ctrl_ALUopcode), .ctrl_shiftamt(ctrl_shiftamt), .data_result(data_result), .isNotEqual(isNotEqual), .isLessThan(isLessThan), .overflow(overflow));

    initial begin;
        $display("A: %b\nB: %b\nctrl_ALUopcode: %b\nctrl_shiftamt: %b\nresult: %b\nisNotEqual: %b\nisLessThan: %b\noverflow: %b", data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);
    end
endmodule